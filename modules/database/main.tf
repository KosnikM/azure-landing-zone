resource "azurerm_mssql_server" "this" {
  name                         = "sql-landing-zone-mk"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "this" {
  name      = "db-mk-${var.environment}"
  server_id = azurerm_mssql_server.this.id
  sku_name  = "Basic"
  geo_backup_enabled = false
}