
#Windows Virtual Machine
resource "azurerm_public_ip" "vm_pip" {
  name                = "${var.project}-${var.environment}-pip"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
    project     = var.project
  }
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.project}-${var.environment}-nic"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.project}-${var.environment}-nic-config"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "${var.project}-${var.environment}-vm"
  computer_name         = substr("${var.project}${var.environment}", 0, 15)
  location              = data.azurerm_resource_group.resource_group.location
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = var.vm_size
  admin_username        = var.vm_username
  admin_password        = var.vm_password
  patch_mode            = "AutomaticByPlatform"
  hotpatching_enabled   = var.vm_image_sku == "2022-datacenter-azure-edition-core" ? true : false

  identity {
    type = "SystemAssigned"
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  os_disk {
    name                 = "${var.project}-${var.environment}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = {
    environment = var.environment
    project     = var.project
    startup     = var.vm_startup_automation
    shutdown    = var.vm_stop_automation
    restart     = var.vm_restart_automation
  }
}

#WinRM Server Setup Extension
resource "azurerm_virtual_machine_extension" "vm_custom_extension_winrm" {
  name                 = "WinRM-Setup"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings           = <<SETTINGS
    {
        "fileUris": ["https://raw.githubusercontent.com/CityHallin/public/main/resources/ansible/winrm_setup.ps1"]
    }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File winrm_setup.ps1"
    }
  PROTECTED_SETTINGS  

  tags = {
    environment = var.environment
    project     = var.project
  }
}

#Reader role for VM used for backup ability
resource "azurerm_role_assignment" "rbac_vm_reader" {
  scope                = data.azurerm_resource_group.resource_group.id
  role_definition_name = "Reader"
  principal_id         = azurerm_windows_virtual_machine.vm.identity.0.principal_id

}