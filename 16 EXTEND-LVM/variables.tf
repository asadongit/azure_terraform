variable "location" {
  type = string
}

variable "vm_id" {
  default = null
}

variable "vm_name" {
  default = null
}

variable "resource_group_name" {
  type = string
}

variable "data_disk_lun" {
  type = number
}

variable "vg_name" {
  type = string
}

variable "lv_name" {
  type = string
}

variable "mount_point" {
  type = string
}

variable "filesystem" {
  default = "xfs"
}