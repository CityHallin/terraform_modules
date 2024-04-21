
#Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.project}-${var.environment}-law"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    environment = var.environment
    project     = var.project
  }
}

resource "azurerm_virtual_machine_extension" "vm_mma_agent_extension" {
  name                 = "MicrosoftMonitoringAgent"
  virtual_machine_id   = data.azurerm_virtual_machine.virtual_machine.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "MicrosoftMonitoringAgent"
  type_handler_version = "1.0"
  settings             = <<SETTINGS
    {
      "workspaceId": "${azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id}"
    }
SETTINGS
  protected_settings   = <<PROTECTED_SETTINGS
   {
      "workspaceKey": "${azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key}"
   }
PROTECTED_SETTINGS
  depends_on           = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

#LAW Data Sources - Win Events
resource "azurerm_log_analytics_datasource_windows_event" "data_source_event_application" {
  name                = "Application"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  event_log_name      = "Application"
  event_types         = ["Error", "Information", "Warning"]
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

resource "azurerm_log_analytics_datasource_windows_event" "data_source_event_system" {
  name                = "System"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  event_log_name      = "System"
  event_types         = ["Error", "Information", "Warning"]
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

#LAW Data Sources - Performance Counters
resource "azurerm_log_analytics_datasource_windows_performance_counter" "data_source_perf_cpu" {
  name                = "CPU"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  object_name         = "Processor"
  instance_name       = "_Total"
  counter_name        = "% Processor Time"
  interval_seconds    = 60
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "data_source_perf_memory" {
  name                = "Memory"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  object_name         = "Memory"
  instance_name       = "*"
  counter_name        = "Available MBytes"
  interval_seconds    = 60
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "data_source_perf_disk" {
  name                = "LogicalDisk"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  object_name         = "LogicalDisk"
  instance_name       = "*"
  counter_name        = "Free Megabytes"
  interval_seconds    = 60
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "data_source_perf_process_cpu" {
  name                = "ProcessCPU"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  object_name         = "Process"
  instance_name       = "*"
  counter_name        = "% Processor Time"
  interval_seconds    = 60
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "data_source_perf_process_memory_private" {
  name                = "ProcessMemoryPrivate"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  object_name         = "Process"
  instance_name       = "*"
  counter_name        = "Private Bytes"
  interval_seconds    = 60
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "data_source_perf_process_memory_working_set" {
  name                = "ProcessMemoryWorkingSet"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  object_name         = "Process"
  instance_name       = "*"
  counter_name        = "Working Set"
  interval_seconds    = 60
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}

resource "azurerm_log_analytics_datasource_windows_performance_counter" "data_source_perf_process_memory_working_set_private" {
  name                = "ProcessMemoryWorkingSetPrivate"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_name      = azurerm_log_analytics_workspace.log_analytics_workspace.name
  object_name         = "Process"
  instance_name       = "*"
  counter_name        = "Working Set - Private"
  interval_seconds    = 60
  depends_on          = [azurerm_log_analytics_workspace.log_analytics_workspace]
}