
#Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.project}-${var.environment}"
  location = var.region
  tags = {
    environment = var.environment
    project     = var.project
  }
}