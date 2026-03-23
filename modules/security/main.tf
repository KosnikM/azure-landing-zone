resource "azurerm_key_vault" "this" {
  name                        = "kv-landing-zone-mk"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
  rbac_authorization_enabled = true
}

resource "azurerm_key_vault_secret" "this" {
  for_each = var.key_vault_secrets
  name = each.key
  value = each.value
  key_vault_id = azurerm_key_vault.this.id
}