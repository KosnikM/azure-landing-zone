resource "azurerm_virtual_network" "this" {
  for_each            = var.vnets
  name                = "vnet-${each.key}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = each.value.address_space
}

locals {
  subnets = flatten([
    for vnet_key, vnet in var.vnets : [
      for subnet_key, subnet in vnet.subnets : {
        vnet_key       = vnet_key
        subnet_key     = subnet_key
        address_prefix = subnet.address_prefix
      }
    ]
  ])
}

resource "azurerm_subnet" "this" {
  for_each             = { for s in local.subnets : "${s.vnet_key}-${s.subnet_key}" => s }
  name                 = each.value.subnet_key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_key].name
  address_prefixes     = [each.value.address_prefix]
}

resource "azurerm_virtual_network_peering" "this" {
  for_each                  = var.peering
  name                      = "peering-${each.key}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.this[each.value.source].name
  remote_virtual_network_id = azurerm_virtual_network.this[each.value.target].id
}
