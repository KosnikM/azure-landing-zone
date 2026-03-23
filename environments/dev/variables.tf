variable "environment" {
  type    = string
  default = "dev"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "vnets" {
  type = map(object({
    address_space = list(string)
    subnets = map(object({
      address_prefix = string
    }))
  }))
}

variable "peering" {
  type = map(object({
    source = string
    target = string
  }))
}

variable "nsg_subnet_key" {
  type = string
}

variable "firewall_private_ip" {
  type    = string
  default = "10.0.1.4"
}

variable "private_dns_zones" {
  type = list(string)
}

variable "vnet_link_key" {
  type = string
}

variable "key_vault_secrets" {
  type = map(string)
}

variable "current_user_object_id" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B2ats_v2"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "ssh_public_key" {
  type = string
}

variable "sql_admin_login" {
  type    = string
  default = "sqladmin"
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "alert_email" {
  type = string
}