output "vm_id" {
    description = "vm_id:"
  value = azurerm_linux_virtual_machine.this.id
}

output "app_service_id" {
    description = "app_service_id:"
  value = azurerm_linux_web_app.this.id
}