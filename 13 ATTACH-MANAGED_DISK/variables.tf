variable "resource_group_name" {
  description = "Resource Group containing the VM and Managed Disk."
  type        = string
}

variable "vm_id" {
  description = "Existing VM ID."
  type        = string
  default     = null
}

variable "vm_name" {
  description = "Existing VM name."
  type        = string
  default     = null
}

variable "managed_disk_id" {
  description = "Existing Managed Disk ID."
  type        = string
  default     = null
}

variable "managed_disk_name" {
  description = "Existing Managed Disk name."
  type        = string
  default     = null
}

variable "lun" {
  description = "Logical Unit Number."

  type = number

  default = 0
}

variable "caching" {

  description = "Disk caching mode."

  type = string

  default = "ReadWrite"

  validation {

    condition = contains([
      "None",
      "ReadOnly",
      "ReadWrite"
    ], var.caching)

    error_message = "Caching must be None, ReadOnly or ReadWrite."

  }

}

variable "write_accelerator_enabled" {

  description = "Enable Write Accelerator."

  type = bool

  default = false

}