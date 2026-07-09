############################################
# Core / VM
############################################

variable "vm_name" {
  description = "Name of the virtual machine (also used to derive NIC / public IP names)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for all resources created by this module"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID the NIC will be placed in"
  type        = string
  default     = null
}

variable "subnet_name" {
  description = "Existing subnet name."
  type        = string
  default     = null
}

variable "vnet_name" {
  description = "Virtual Network name."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "Availability zone for the VM"
  type        = string
  default     = null
}

variable "vm_size" {
  description = "VM SKU size"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "authentication_type" {
  description = "Either \"ssh\" or \"password\""
  type        = string

  validation {
    condition     = contains(["ssh", "password"], var.authentication_type)
    error_message = "authentication_type must be either \"ssh\" or \"password\"."
  }
}

variable "admin_password" {
  description = "Admin password, required when authentication_type = \"password\""
  type        = string
  default     = null
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key, required when authentication_type = \"ssh\""
  type        = string
  default     = null
}

variable "custom_image_id" {
  description = "Resource ID of a custom/managed image. If set, publisher/offer/sku/image_version are ignored."
  type        = string
  default     = null
}

variable "publisher" {
  description = "Marketplace image publisher (ignored if custom_image_id is set)"
  type        = string
  default     = null
}

variable "offer" {
  description = "Marketplace image offer (ignored if custom_image_id is set)"
  type        = string
  default     = null
}

variable "sku" {
  description = "Marketplace image SKU (ignored if custom_image_id is set)"
  type        = string
  default     = null
}

variable "image_version" {
  description = "Marketplace image version (ignored if custom_image_id is set)"
  type        = string
  default     = "latest"
}

############################################
# Public IP
############################################

variable "create_public_ip" {
  description = "If true, create a new public IP and attach it to the NIC"
  type        = bool
  default     = false
}

variable "public_ip_sku" {
  description = "SKU for the public IP when create_public_ip = true"
  type        = string
  default     = "Standard"
}

variable "public_ip_input" {
  description = <<-EOT
    Existing public IP to attach when create_public_ip = false.
    Accepts EITHER a plain resource name (e.g. "my-pip") OR a full Azure
    resource ID (e.g. "/subscriptions/.../publicIPAddresses/my-pip").
    Leave null to attach no public IP at all.
  EOT
  type    = string
  default = null
}

variable "public_ip_resource_group_name" {
  description = "Resource group of the existing public IP when public_ip_input is a name. Defaults to resource_group_name."
  type        = string
  default     = null
}
