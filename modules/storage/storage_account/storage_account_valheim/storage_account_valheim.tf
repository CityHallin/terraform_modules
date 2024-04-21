
#Storage Account for function and backups
resource "azurerm_storage_account" "storage_account" {
  name                     = "cityhallin${var.project}${var.environment}"
  resource_group_name      = data.azurerm_resource_group.resource_group.name
  location                 = data.azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
    project     = var.project
  }
}

resource "azurerm_storage_container" "container_backup" {
  name                  = "${var.project}-backup"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "rbac_container_backup_vm" {
  scope                = azurerm_storage_account.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_virtual_machine.virtual_machine.identity.0.principal_id
  depends_on           = [data.azurerm_virtual_machine.virtual_machine]
}