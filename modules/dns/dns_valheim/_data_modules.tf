
data "azurerm_resource_group" "resource_group" {
  name = "${var.project}-${var.environment}"
}

data "azurerm_virtual_machine" "virtual_machine" {
  name                = "${var.project}-${var.environment}-vm"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_dns_zone" "dns_dev" {
  count               = (var.environment == "dev" ? 1 : 0)
  name                = "${var.environment}.${var.dns_namespace}"
  resource_group_name = "core${var.environment}"
}

data "azurerm_dns_zone" "dns_prd" {
  count               = (var.environment == "prd" ? 1 : 0)
  name                = var.dns_namespace
  resource_group_name = "core${var.environment}"
}

data "azurerm_public_ip" "vm_pip" {
  name                = data.azurerm_virtual_machine.virtual_machine.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
}