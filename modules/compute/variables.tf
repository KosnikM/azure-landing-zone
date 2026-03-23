variable "environment" {
type = string
}
variable "location" {
type = string
}
variable "resource_group_name"{
type = string
}
variable "subnet_id" {
type = string
}
variable "identity_id" {
type = string
}
variable "vm_size" {
type = string
}

variable "admin_user" {
type = string
}

variable "ssh_public_key" {
    type = string
}
variable "key_vault_secret_uri" {
  type    = string
  default = ""
}