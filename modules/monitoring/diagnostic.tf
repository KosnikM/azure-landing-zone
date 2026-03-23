resource "azurerm_monitor_diagnostic_setting" "this" {
 for_each = var.monitored_resources
  name                       = "diag-${each.key}=${var.environment}"
  target_resource_id         = each.value
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_metric {
    category = "AllMetrics"
  }
}