variable "public_ip_name" {
  description = "Name of the Public IP."
  type        = string

  validation {
    condition     = length(var.public_ip_name) > 0
    error_message = "Public IP name cannot be empty."
  }
}

variable "resource_group_name" {
  description = "Existing Resource Group."
  type        = string
}

variable "location" {
  description = "Azure Region."
  type        = string
}

variable "sku" {
  description = "Public IP SKU."

  type = string

  default = "Standard"

  validation {
    condition = contains(
      ["Basic", "Standard"],
      var.sku
    )

    error_message = "SKU must be either Basic or Standard."
  }
}

variable "allocation_method" {

  description = "Allocation Method."

  type = string

  default = "Static"

  validation {

    condition = contains(
      ["Static", "Dynamic"],
      var.allocation_method
    )

    error_message = "Allocation Method must be Static or Dynamic."
  }
}

variable "zones" {

  description = "Availability Zones."

  type = list(string)

  default = null
}

variable "tags" {

  description = "Tags."

  type = map(string)

  default = {}
}