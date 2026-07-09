############################################################
# General
############################################################

variable "vm_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "availability_zone" {
  type    = string
  default = null
}

variable "vm_size" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

############################################################
# Network Interface
############################################################

variable "nic_id" {
  description = "Existing NIC ID."
  type        = string
  default     = null
}

variable "nic_name" {
  description = "Existing NIC name."
  type        = string
  default     = null
}

############################################################
# Authentication
############################################################

variable "admin_username" {
  type = string
}

variable "authentication_type" {

  type = string

  validation {

    condition = contains(
      ["ssh", "password"],
      var.authentication_type
    )

    error_message = "authentication_type must be ssh or password."
  }
}

variable "admin_password" {
  type      = string
  default   = null
  sensitive = true
}

variable "ssh_public_key" {
  type    = string
  default = null
}

############################################################
# Image
############################################################

variable "custom_image_id" {
  type    = string
  default = null
}

variable "publisher" {
  type    = string
  default = "Canonical"
}

variable "offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}

variable "sku" {
  type    = string
  default = "22_04-lts-gen2"
}

variable "image_version" {
  type    = string
  default = "latest"
}

############################################################
# OS Disk
############################################################

variable "os_disk_storage_account_type" {

  type    = string

  default = "Standard_LRS"
}

variable "os_disk_caching" {

  type    = string

  default = "ReadWrite"
}