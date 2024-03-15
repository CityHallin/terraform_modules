
#CosmosDB Account
resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                      = "${var.project}-${var.environment}-cdb"
  location                  = azurerm_resource_group.resource_group.location
  resource_group_name       = azurerm_resource_group.resource_group.name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = true

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.resource_group.location
    failover_priority = 0
  }

  tags = {
    environment = var.environment
    project     = var.project
  }
}

#CosmosDB Database
resource "azurerm_cosmosdb_sql_database" "cosmosdb_db" {
  name                = "resume"
  resource_group_name = azurerm_resource_group.resource_group.name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
}

#CosmosDB Container
resource "azurerm_cosmosdb_sql_container" "cosmosdb_container" {
  name                  = "profiles"
  resource_group_name   = azurerm_resource_group.resource_group.name
  account_name          = azurerm_cosmosdb_account.cosmosdb_account.name
  database_name         = azurerm_cosmosdb_sql_database.cosmosdb_db.name
  partition_key_path    = "/id"
  partition_key_version = 1
}
