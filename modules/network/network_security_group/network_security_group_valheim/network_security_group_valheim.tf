
#Network Security Group
resource "azurerm_network_security_group" "network_security_group" {
  name                = "${var.project}-${var.environment}-nsg"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  tags = {
    environment = var.environment
    project     = var.project
  }
}

resource "azurerm_network_security_rule" "nsg_rule_rdp" {
  name                        = "RDP"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = var.remote_ip_address
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_network_security_rule" "nsg_rule_steam_tcp" {
  name                        = "Steam_TCP"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2457"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_network_security_rule" "nsg_rule_steam_udp" {
  name                        = "Steam_UDP"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "2457"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_network_security_rule" "nsg_rule_valheim_udp" {
  name                        = "Valheim_UDP"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "2456"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_network_security_rule" "nsg_rule_valheim_tcp" {
  name                        = "Valheim_TCP"
  priority                    = 107
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2456"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_network_security_rule" "nsg_rule_winrm" {
  name                        = "WinRM"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5986"
  source_address_prefix       = var.runner_ip_address
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

resource "azurerm_subnet_network_security_group_association" "network_security_group_association" {
  subnet_id                 = data.azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}