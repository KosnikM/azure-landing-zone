output "sql_server_id" {
    description = "sql-server-id:"
  value = azurerm_mssql_server.this.id
}

output "database_id" {
    description = "database-id:"
  value = azurerm_mssql_database.this.id
}