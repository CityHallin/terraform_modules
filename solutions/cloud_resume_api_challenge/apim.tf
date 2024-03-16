
#APIM Instance
resource "azurerm_api_management" "apim" {
  name                          = "${var.project}-${var.environment}-apim"
  location                      = azurerm_resource_group.resource_group.location
  resource_group_name           = azurerm_resource_group.resource_group.name
  publisher_name                = var.project
  publisher_email               = "${var.project}@${var.project}.com"
  sku_name                      = "Consumption_0"
  public_network_access_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.environment
    project     = var.project
  }

  depends_on = [azurerm_key_vault_secret.cosmos_key]

}

# AIPM Named Value for Function App Host Key
data "azurerm_function_app_host_keys" "function_app_host_key" {
  name                = azurerm_windows_function_app.windows_function_app.name
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_api_management_named_value" "apim_named_value" {
  name                = "${azurerm_windows_function_app.windows_function_app.name}-key"
  resource_group_name = azurerm_resource_group.resource_group.name
  api_management_name = azurerm_api_management.apim.name
  display_name        = "${azurerm_windows_function_app.windows_function_app.name}-key"
  value               = data.azurerm_function_app_host_keys.function_app_host_key.default_function_key
  secret              = true
}

#APIM Identity Key Vault RBAC
resource "azurerm_role_assignment" "rbac_key_vault_apim" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_api_management.apim.identity[0].principal_id
  depends_on           = [azurerm_key_vault.key_vault, azurerm_api_management.apim]
}

#APIM Version Set
resource "azurerm_api_management_api_version_set" "apim_version_set" {
  name                = "resume"
  resource_group_name = azurerm_resource_group.resource_group.name
  api_management_name = azurerm_api_management.apim.name
  display_name        = "resume"
  versioning_scheme   = "Segment"
}

#APIM API
resource "azurerm_api_management_api" "api" {
  name                  = "resume"
  resource_group_name   = azurerm_resource_group.resource_group.name
  api_management_name   = azurerm_api_management.apim.name
  revision              = "1"
  display_name          = "resume"
  protocols             = ["https"]
  subscription_required = false
  version               = "v1"
  version_set_id        = azurerm_api_management_api_version_set.apim_version_set.id
}

#APIM Backend and Policy
resource "azurerm_api_management_backend" "apim_backend" {
  name                = azurerm_storage_account.storage_account.name
  resource_group_name = azurerm_resource_group.resource_group.name
  api_management_name = azurerm_api_management.apim.name
  protocol            = "http"
  url                 = "https://${azurerm_windows_function_app.windows_function_app.default_hostname}/api"

  credentials {
    header = {
      x-functions-key = "{{${azurerm_api_management_named_value.apim_named_value.name}}}"
    }
  }
}

resource "azurerm_api_management_api_operation" "api_operation" {
  operation_id        = "get-resume"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.resource_group.name
  display_name        = "resume"
  method              = "GET"
  url_template        = "/resume"
}

resource "azurerm_api_management_api_operation_policy" "api_operation_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.resource_group.name
  operation_id        = azurerm_api_management_api_operation.api_operation.operation_id

  xml_content = <<XML
<policies>
    <inbound>
        <base />
        <rate-limit calls="25" renewal-period="90" remaining-calls-variable-name="remainingCallsPerSubscription" />
        <set-backend-service id="apim-generated-policy" backend-id="${azurerm_api_management_backend.apim_backend.name}" />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML

}