
data "azurerm_resource_group" "resource_group" {
  name = "${var.project}-${var.environment}"
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.project}-${var.environment}-law"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}
