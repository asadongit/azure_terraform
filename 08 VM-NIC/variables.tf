variable "nic_name" {
  description = "Network Interface name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group."
  type        = string
}

variable "location" {
  description = "Azure Region."
  type        = string
}

variable "subnet_id" {
  description = "Existing subnet ID."
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

variable "public_ip_name" {
  description = "Public IP name."
  type        = string
  default     = null
}

variable "public_ip_id" {
  description = "Existing Public IP ID."
  type        = string
  default     = null
}

variable "private_ip_address_allocation" {

  type = string

  default = "Dynamic"

  validation {

    condition = contains(
      ["Dynamic", "Static"],
      var.private_ip_address_allocation
    )

    error_message = "Must be Dynamic or Static."
  }
}

variable "private_ip_address" {

  description = "Static Private IP."

  type = string

  default = null
}

variable "tags" {

  type = map(string)

  default = {}
}