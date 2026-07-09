variable "resource_group_name" {
  description = "Existing Resource Group where the NSG will be created."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "nsg_name" {
  description = "Name of the Network Security Group."

  type = string

  validation {
    condition     = length(var.nsg_name) >= 1 && length(var.nsg_name) <= 80
    error_message = "NSG name must be between 1 and 80 characters."
  }
}

variable "tags" {
  description = "Tags applied to the NSG."

  type    = map(string)
  default = {}
}