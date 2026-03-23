resource "azurerm_user_assigned_identity" "this" {
  name                = "identity-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
}
