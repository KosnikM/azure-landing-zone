variable "environment" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "tenant_id" {
    type = string
}
variable "key_vault_secrets" {
    type = map(string)
}
variable "current_user_object_id" {
  type = string
}