variable "resource_group_name" {
  description = "Name of the existing resource group containing the disk"
  type        = string
}

variable "location" {
  description = "Azure region of the disk"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone of the disk"
  type        = string
}

variable "disk_name" {
  description = "Name of the existing managed disk to import and manage"
  type        = string
}

variable "storage_account_type" {
  description = "Storage account type (e.g. Premium_LRS, Standard_LRS, StandardSSD_LRS)"
  type        = string
  default     = "Standard_LRS"
}

variable "create_option" {
  description = "Create option for the managed disk"
  type        = string
  default     = "Empty"
}

variable "disk_size_gb" {
  description = "Target size of the disk in GB (can only increase, not decrease)"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the disk"
  type        = map(string)
  default     = {}
}