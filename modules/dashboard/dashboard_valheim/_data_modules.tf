
data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "resource_group" {
  name = "${var.project}-${var.environment}"
}

data "azurerm_virtual_machine" "virtual_machine" {
  name                = "${var.project}-${var.environment}-vm"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.project}-${var.environment}-law"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}
