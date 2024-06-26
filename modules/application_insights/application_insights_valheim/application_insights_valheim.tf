#Application Insights
resource "azurerm_application_insights" "application_insights" {
  name                = "${var.project}-${var.environment}-ai"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  workspace_id        = data.azurerm_log_analytics_workspace.log_analytics_workspace.id
  application_type    = "web"

  tags = {
    environment = var.environment
    project     = var.project
  }

  depends_on = [data.azurerm_log_analytics_workspace.log_analytics_workspace]
}