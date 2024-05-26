
data "azurerm_resource_group" "resource_group" {
  name = "${var.project}-${var.environment}"
}

data "azurerm_virtual_machine" "virtual_machine" {
  name                = "${var.project}-${var.environment}-vm"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_storage_account" "storage_account" {
  name                = "cityhallin${var.project}${var.environment}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.project}-${var.environment}-law"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_application_insights" "application_insights" {
  name                = "${var.project}-${var.environment}-ai"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}
