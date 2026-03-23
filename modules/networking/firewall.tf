/*
resource "azurerm_public_ip" "this" {
  name                = "pip-firewall-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "this" {
  name                = "fw-hub-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "fw-ip-config"
    subnet_id            = azurerm_subnet.this["hub-AzureFirewallSubnet"].id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

resource "azurerm_firewall_network_rule_collection" "this" {
  
}

resource "azurerm_firewall_application_rule_collection" "this" {

}

resource "azurerm_firewall_nat_rule_collection" "this" {
  
}
*/