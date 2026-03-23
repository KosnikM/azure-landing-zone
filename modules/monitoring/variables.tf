variable "environment" {
type = string
}
variable "location" {
type = string
}
variable "resource_group_name"{
type = string
}
variable "monitored_resources" {
 type = map(string)
}

variable "alert_email" {
 type = string
}

variable "vm_id" {
 type = string
}