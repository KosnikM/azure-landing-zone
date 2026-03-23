variable "environment" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
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
  type = string
}

variable "private_dns_zones" {
  type = list(string)
}

variable "vnet_link_key" {
  type = string
}