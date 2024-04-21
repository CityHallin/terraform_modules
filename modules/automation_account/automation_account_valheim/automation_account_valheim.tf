
#Automation Account
resource "azurerm_automation_account" "automation_account" {
  name                = "${var.project}-${var.environment}-aa"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  sku_name            = "Basic"
  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = var.environment
    project     = var.project
  }
}

resource "azurerm_role_assignment" "rbac" {
  scope                = data.azurerm_virtual_machine.virtual_machine.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_automation_account.automation_account.identity.0.principal_id
}

#Runbook Stop VM
resource "azurerm_automation_runbook" "runbook_stopvm" {
  name                    = "StopVM"
  location                = data.azurerm_resource_group.resource_group.location
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  log_verbose             = false
  log_progress            = true
  description             = "Stop VMs"
  runbook_type            = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/CityHallin/valheim/main/azure/runbooks/stop_vms_by_tag.ps1"
  }
}

resource "azurerm_automation_schedule" "runbook_stopvm_schedule" {
  name                    = "everyday1am"
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  frequency               = "Day"
  interval                = 1
  timezone                = "America/Denver"
  start_time              = "${local.date}T01:00:00-07:00"
  description             = " "
}

resource "azurerm_automation_job_schedule" "runbook_stopvm_job_schedule" {
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  schedule_name           = azurerm_automation_schedule.runbook_stopvm_schedule.name
  runbook_name            = azurerm_automation_runbook.runbook_stopvm.name
}

#Runbook Start VM
resource "azurerm_automation_runbook" "runbook_startvm" {
  name                    = "StartVM"
  location                = data.azurerm_resource_group.resource_group.location
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  log_verbose             = false
  log_progress            = true
  description             = "Start VMs"
  runbook_type            = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/CityHallin/valheim/main/azure/runbooks/start_vms_by_tag.ps1"
  }
}

resource "azurerm_automation_schedule" "runbook_startvm_schedule" {
  name                    = "everyday12pm"
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  frequency               = "Day"
  interval                = 1
  timezone                = "America/Denver"
  start_time              = "${local.date}T12:00:00-07:00"
  description             = " "
}

resource "azurerm_automation_schedule" "runbook_startvm_schedule_weekend" {
  name                    = "everyday9am"
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  frequency               = "Day"
  interval                = 1
  timezone                = "America/Denver"
  start_time              = "${local.date}T09:00:00-07:00"
  description             = " "
}

resource "azurerm_automation_job_schedule" "runbook_startvm_job_schedule" {
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  schedule_name           = azurerm_automation_schedule.runbook_startvm_schedule.name
  runbook_name            = azurerm_automation_runbook.runbook_startvm.name
}

resource "azurerm_automation_job_schedule" "runbook_startvm_job_schedule_weekend" {
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  schedule_name           = azurerm_automation_schedule.runbook_startvm_schedule_weekend.name
  runbook_name            = azurerm_automation_runbook.runbook_startvm.name
}

#Runbook Restart VM
resource "azurerm_automation_runbook" "runbook_restartvm" {
  name                    = "RestartVM"
  location                = data.azurerm_resource_group.resource_group.location
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  log_verbose             = false
  log_progress            = true
  description             = "Restart VMs"
  runbook_type            = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/CityHallin/valheim/main/azure/runbooks/restart_vm_by_tag.ps1"
  }
}

#Runbook VM backup
resource "azurerm_automation_runbook" "runbook_backup" {
  name                    = "BackupValheim"
  location                = data.azurerm_resource_group.resource_group.location
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  automation_account_name = azurerm_automation_account.automation_account.name
  log_verbose             = false
  log_progress            = true
  description             = "Backup Valheim world"
  runbook_type            = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/CityHallin/valheim/main/azure/runbooks/runbook_backup.ps1"
  }
}