variable "resource_group_name" {
  type    = string
  default = null
}

variable "nsg_name" {
  type    = string
  default = null
}

variable "nsg_id" {
  type    = string
  default = null
}

variable "nic_names" {
  type    = set(string)
  default = []
}

variable "nic_ids" {
  type    = set(string)
  default = []
}