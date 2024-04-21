
#Valheim Server Solution
module "resource_group_default" {
  source      = "github.com/CityHallin/terraform_modules/modules/resource_group/resource_group_default"
  project     = var.project
  environment = var.environment
  region      = var.region
}

module "default_virtual_network" {
  source             = "github.com/CityHallin/terraform_modules/modules/network/virtual_network/virtual_network_default"
  project            = var.project
  environment        = var.environment
  region             = var.region
  vnet_address_range = var.vnet_address_range
  snet_address_range = var.snet_address_range
  depends_on         = [module.resource_group_default]
}

module "storage_account_valheim" {
  source      = "github.com/CityHallin/terraform_modules/modules/storage/storage_account/storage_account_valheim"
  project     = var.project
  environment = var.environment
  region      = var.region
  depends_on  = [module.resource_group_default, module.virtual_machine_windows_default]
}

module "virtual_machine_windows_default" {
  source                = "github.com/CityHallin/terraform_modules/modules/compute/virtual_machine/virtual_machine_windows_default"
  project               = var.project
  environment           = var.environment
  region                = var.region
  vm_username           = var.vm_username
  vm_password           = var.vm_password
  vm_size               = var.vm_size
  vm_image_publisher    = var.vm_image_publisher
  vm_image_offer        = var.vm_image_offer
  vm_image_sku          = var.vm_image_sku
  vm_image_version      = var.vm_image_version
  vm_startup_automation = var.vm_startup_automation
  vm_stop_automation    = var.vm_stop_automation
  vm_restart_automation = var.vm_restart_automation
  depends_on            = [module.resource_group_default, module.default_virtual_network]
}

module "network_security_group_valheim" {
  source            = "github.com/CityHallin/terraform_modules/modules/network/network_security_group/network_security_group_valheim"
  project           = var.project
  environment       = var.environment
  region            = var.region
  remote_ip_address = var.remote_ip_address
  runner_ip_address = var.runner_ip_address
  depends_on        = [module.resource_group_default, module.default_virtual_network]
}

module "log_analytics_workspace_valheim" {
  source      = "github.com/CityHallin/terraform_modules/modules/monitor/log_analytics_workspace/log_analytics_workspace_valheim"
  project     = var.project
  environment = var.environment
  region      = var.region
  depends_on  = [module.resource_group_default, module.virtual_machine_windows_default]
}

module "dns_valheim" {
  source        = "github.com/CityHallin/terraform_modules/modules/dns/dns_valheim"
  project       = var.project
  environment   = var.environment
  region        = var.region
  dns_namespace = var.dns_namespace
  depends_on    = [module.resource_group_default, module.virtual_machine_windows_default]
}

module "dashboard_valheim" {
  source      = "github.com/CityHallin/terraform_modules/modules/dashboard/dashboard_valheim"
  project     = var.project
  environment = var.environment
  region      = var.region
  depends_on  = [module.resource_group_default, module.virtual_machine_windows_default, module.log_analytics_workspace_valheim]
}

module "automation_account_valheim" {
  source      = "github.com/CityHallin/terraform_modules/modules/automation_account/automation_account_valheim"
  project     = var.project
  environment = var.environment
  region      = var.region
  depends_on  = [module.resource_group_default, module.virtual_machine_windows_default]
}

