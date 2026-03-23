output "key_vault_id" {
    description = "key-vault-id"
  value = azurerm_key_vault.this.id
}

output "identity_id" {
    description = "identity-id:"
  value = azurerm_user_assigned_identity.this.id
}

output "identity_principal_id" {
    description = "identity-principal-id:"
  value = azurerm_user_assigned_identity.this.principal_id
}