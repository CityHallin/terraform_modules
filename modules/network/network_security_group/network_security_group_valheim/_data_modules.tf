
data "azurerm_resource_group" "resource_group" {
  name = "${var.project}-${var.environment}"
}

data "azurerm_subnet" "subnet" {
  name                 = var.project
  virtual_network_name = "${var.project}-${var.environment}-vnet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
}