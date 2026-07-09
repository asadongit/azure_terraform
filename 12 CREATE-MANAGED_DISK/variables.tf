variable "disk_name" {
  description = "Managed Disk name."
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

variable "disk_size_gb" {
  description = "Disk size in GB."
  type        = number
}

variable "storage_account_type" {
  description = "Disk SKU."

  type = string

  default = "StandardSSD_LRS"

  validation {
    condition = contains([
      "Standard_LRS",
      "StandardSSD_LRS",
      "Premium_LRS",
      "PremiumV2_LRS",
      "UltraSSD_LRS"
    ], var.storage_account_type)

    error_message = "Invalid storage account type."
  }
}

variable "create_option" {
  description = "Create Option."

  type = string

  default = "Empty"

  validation {
    condition = contains([
      "Empty",
      "Copy",
      "Import",
      "Restore"
    ], var.create_option)

    error_message = "Invalid create option."
  }
}

variable "availability_zone" {
  description = "Availability Zone."

  type    = string
  default = null
}

variable "tags" {

  type = map(string)

  default = {}

}