
#App Service Plan
resource "azurerm_service_plan" "windows_service_plan" {
  name                = "${var.project}-${var.environment}-asp"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  os_type             = "Windows"
  sku_name            = "Y1"

  tags = {
    environment = var.environment
    project     = var.project
  }
}

#Function App
resource "azurerm_windows_function_app" "windows_function_app" {
  name                          = "${var.project}${var.environment}wfunc"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  storage_account_name          = azurerm_storage_account.storage_account.name
  storage_account_access_key    = azurerm_storage_account.storage_account.primary_access_key
  service_plan_id               = azurerm_service_plan.windows_service_plan.id
  https_only                    = true
  public_network_access_enabled = true
  zip_deploy_file               = data.archive_file.compress_function_files.output_path

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1",
    "FUNCTIONS_WORKER_RUNTIME" = "powershell",
    "FUNCTIONS_WORKER_RUNTIME_VERSION" : "7.2",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key,
    "FUNCTIONS_EXTENSION_VERSION"    = "~4",
    "KEYVAULT_NAME"                  = azurerm_key_vault.key_vault.name,
    "KEYVAULT_SECRET_NAME"           = azurerm_key_vault_secret.cosmos_key.name,
    "DB_ACCOUNT_NAME"                = azurerm_cosmosdb_account.cosmosdb_account.name,
    "DB_NAME"                        = azurerm_cosmosdb_sql_database.cosmosdb_db.name,
    "COLLECTION_NAME"                = azurerm_cosmosdb_sql_container.cosmosdb_container.name
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_connection_string = azurerm_application_insights.application_insights.connection_string
    application_insights_key               = azurerm_application_insights.application_insights.instrumentation_key

    application_stack {
      powershell_core_version = "7.2"
    }

    cors {
      allowed_origins = [
        "https://portal.azure.com",
      ]
      support_credentials = false
    }
  }

  tags = {
    environment = var.environment
    project     = var.project
  }

  depends_on = [azurerm_log_analytics_workspace.log_analytics_workspace, azurerm_application_insights.application_insights, azurerm_key_vault.key_vault]
}

#Function App Identity Key Vault RBAC
resource "azurerm_role_assignment" "rbac_key_vault_functionapp" {
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_windows_function_app.windows_function_app.identity.0.principal_id
  depends_on           = [azurerm_key_vault.key_vault, azurerm_windows_function_app.windows_function_app]
}
