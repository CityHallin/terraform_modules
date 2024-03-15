#Storage Account for function app
resource "azurerm_storage_account" "storage_account" {
  name                             = "crac00${var.project}${var.environment}"
  resource_group_name              = azurerm_resource_group.resource_group.name
  location                         = azurerm_resource_group.resource_group.location
  account_kind                     = "StorageV2"
  account_tier                     = "Standard"
  account_replication_type         = "LRS"
  cross_tenant_replication_enabled = false
  access_tier                      = "Hot"
  enable_https_traffic_only        = true
  min_tls_version                  = "TLS1_2"
  allow_nested_items_to_be_public  = false

  tags = {
    environment = var.environment
    project     = var.project
  }
}
