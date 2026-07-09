variable "resource_group_name" {
  description = "Resource Group containing the resources."
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network name. Required only when subnet names are used."
  type        = string
  default     = null
}

variable "nsg_name" {
  description = "Existing NSG name."
  type        = string
  default     = null
}

variable "nsg_id" {
  description = "Existing NSG ID."
  type        = string
  default     = null
}

variable "subnet_names" {
  description = "Subnet names."
  type        = set(string)
  default     = []
}

variable "subnet_ids" {
  description = "Subnet IDs."
  type        = set(string)
  default     = []
}