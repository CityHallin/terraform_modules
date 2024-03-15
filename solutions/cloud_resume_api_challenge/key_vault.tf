
#Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                        = "${var.project}-${var.environment}-kv"
  location                    = azurerm_resource_group.resource_group.location
  resource_group_name         = azurerm_resource_group.resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  enable_rbac_authorization   = true

  tags = {
    environment = var.environment
    project     = var.project
  }
}

#Add Key Vault Secret
resource "azurerm_key_vault_secret" "cosmos_key" {
  name         = "resume-api-db-key"
  value        = azurerm_cosmosdb_account.cosmosdb_account.primary_readonly_key
  key_vault_id = azurerm_key_vault.key_vault.id

  depends_on = [azurerm_cosmosdb_account.cosmosdb_account]
}
