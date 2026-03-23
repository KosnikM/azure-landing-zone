resource "azurerm_network_security_group" "this" {
  name                = "nsg-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this[var.nsg_subnet_key].id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_security_rule" "allow_ssh" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
  name                        = "allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "*"

}

resource "azurerm_network_security_rule" "deny_http" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
  name                        = "deny-http"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

}
resource "azurerm_network_security_rule" "allow_https" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
  name                        = "allow-https"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "*"

}