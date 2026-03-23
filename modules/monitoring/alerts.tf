resource "azurerm_monitor_action_group" "this" {
  name                = "ag-email-${var.environment}"
  resource_group_name = var.resource_group_name
  short_name          = "email"

  email_receiver {
    name          = "admin"
    email_address = var.alert_email
  }
}

resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "alert-cpu-high"
  resource_group_name = var.resource_group_name
  scopes              = [var.vm_id]
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }
}

resource "azurerm_monitor_metric_alert" "cpu_critical" {
  name                = "alert-cpu-critical"
  resource_group_name = var.resource_group_name
  scopes              = [var.vm_id]
  severity            = 0
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }
}

