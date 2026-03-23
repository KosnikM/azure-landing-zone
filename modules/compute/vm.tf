resource "azurerm_network_interface" "this" {
name = "nic-${var.environment}"
location = var.location
resource_group_name = var.resource_group_name
ip_configuration {
  name = "nic_${var.environment}.configuration"
  subnet_id = var.subnet_id
  private_ip_address_allocation = "Dynamic"
}

}

resource "azurerm_linux_virtual_machine" "this" {
  name = "vm-${var.environment}"
  location = var.location
  resource_group_name = var.resource_group_name
  size = var.vm_size
  admin_username = var.admin_user
  admin_ssh_key {
  username   = var.admin_user
  public_key = var.ssh_public_key
}
  network_interface_ids = [
    azurerm_network_interface.this.id
  ]
    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
    source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }
}