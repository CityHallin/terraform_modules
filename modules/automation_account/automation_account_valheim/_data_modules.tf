
data "azurerm_client_config" "client" {
}

data "azurerm_resource_group" "resource_group" {
  name = "${var.project}-${var.environment}"
}

data "azurerm_virtual_machine" "virtual_machine" {
  name                = "${var.project}-${var.environment}-vm"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}
