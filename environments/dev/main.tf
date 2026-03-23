resource "azurerm_resource_group" "this" {
  name     = "rg-landing-zone-mk-${var.environment}"
  location = var.location
}


module "networking" {
  source = "../../modules/networking"
  environment = var.environment
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  vnets = {
  hub = {
    address_space = ["10.0.0.0/16"]
    subnets = {
      AzureFirewallSubnet = { address_prefix = "10.0.1.0/24" }
    }
  }
  spoke-dev = {
    address_space = ["10.1.0.0/16"]
    subnets = {
      workload          = { address_prefix = "10.1.1.0/24" }
      private-endpoints = { address_prefix = "10.1.2.0/24" }
    }
  }
  spoke-prod = {
    address_space = ["10.2.0.0/16"]
    subnets = {
      workload          = { address_prefix = "10.2.1.0/24" }
      private-endpoints = { address_prefix = "10.2.2.0/24" }
    }
  }
}
  peering = {
  hub-to-spoke-dev  = { source = "hub", target = "spoke-dev" }
  spoke-dev-to-hub  = { source = "spoke-dev", target = "hub" }
  hub-to-spoke-prod = { source = "hub", target = "spoke-prod" }
  spoke-prod-to-hub = { source = "spoke-prod", target = "hub" }
}
  nsg_subnet_key = "spoke-dev-workload"
  firewall_private_ip = "10.0.1.4"
  private_dns_zones = [
  "privatelink.blob.core.windows.net",
  "privatelink.database.windows.net",
  "privatelink.vaultcore.azure.net"
]
  vnet_link_key = "spoke-dev"
}

module "security" {
  source = "../../modules/security"
  environment = var.environment
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  tenant_id = data.azurerm_client_config.current.tenant_id
  current_user_object_id = data.azurerm_client_config.current.object_id
  key_vault_secrets = {
  "sql-connection-string" = "Server=10.2.1.5;Database=payments;User=sqladmin;Password=P@ssw0rd1234!"
  "storage-access-key"    = "example-key-123"
}
}

module "compute" {
  source = "../../modules/compute"
  environment = var.environment
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  subnet_id = module.networking.subnet_ids["spoke-dev-workload"]
  identity_id = module.security.identity_id
  vm_size =  var.vm_size
  admin_user = var.admin_username
  ssh_public_key = file("~/.ssh/id_rsa.pub")
  key_vault_secret_uri = module.security.secret_uris["sql-connection-string"]
}

module "monitoring" {
  source = "../../modules/monitoring"
  environment = var.environment
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  monitored_resources = {
  "vm"       = module.compute.vm_id
  "keyvault" = module.security.key_vault_id
  }
    alert_email = var.alert_email
    vm_id = module.compute.vm_id
}

module "database" {
  source = "../../modules/database"
  environment = var.environment
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  admin_login = var.sql_admin_login
  admin_password = var.sql_admin_password
  subnet_id = module.networking.subnet_ids["spoke-dev-private-endpoints"]
  private_dns_zone = "privatelink.database.windows.net"
}

module "governance" {
  source            = "../../modules/governance"
  resource_group_id = azurerm_resource_group.this.id
}