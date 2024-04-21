#Virtual Network and subnets
resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.project}-${var.environment}-vnet"
  address_space       = var.vnet_address_range
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.project
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.snet_address_range
}