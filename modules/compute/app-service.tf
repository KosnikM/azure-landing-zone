resource "azurerm_service_plan" "this" {
  name                = "asp-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "this" {
  name                = "webapp-landing-zone-mk"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {}

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }
    app_settings = {
     "SQL_CONNECTION_STRING" = "@Microsoft.KeyVault(SecretUri=${var.key_vault_secret_uri})"
  }
}