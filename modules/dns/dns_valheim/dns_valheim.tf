
# DNS by environment
resource "azurerm_dns_a_record" "dns_a_dev" {
  count               = (var.environment == "dev" ? 1 : 0)
  name                = var.project
  zone_name           = data.azurerm_dns_zone.dns_dev[count.index].name
  resource_group_name = data.azurerm_dns_zone.dns_dev[count.index].resource_group_name
  ttl                 = 300
  records             = ["${data.azurerm_virtual_machine.virtual_machine.public_ip_address}"]
}

resource "azurerm_dns_a_record" "dns_a_prd" {
  count               = (var.environment == "prd" ? 1 : 0)
  name                = var.project
  zone_name           = data.azurerm_dns_zone.dns_prd[count.index].name
  resource_group_name = data.azurerm_dns_zone.dns_prd[count.index].resource_group_name
  ttl                 = 300
  records             = ["${data.azurerm_virtual_machine.virtual_machine.public_ip_address}"]
}