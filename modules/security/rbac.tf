resource "azurerm_role_assignment" "this" { 
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_role_assignment" "current_user" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.current_user_object_id
}