output "log_analytics_workspace_id" {
    description = "law-id:"
  value = azurerm_log_analytics_workspace.this.id
}

output "action_group_id" {
    description = "action-group-id:"
  value = azurerm_monitor_action_group.this.id
}