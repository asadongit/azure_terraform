variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
  default = "Standard_B2s"
}

variable "admin_username" {
  type = string
}

variable "authentication_type" {
  type    = string
  default = "ssh" # ssh or password
}

variable "admin_password" {
  type      = string
  sensitive = true
  default   = null
}

variable "ssh_public_key" {
  type    = string
  default = null
}

variable "subnet_id" {
  type = string
}

variable "create_public_ip" {
  type    = bool
  default = false
}

variable "public_ip_sku" {
  type    = string
  default = "Standard"
}

variable "availability_zone" {
  type    = string
  default = null
}

variable "public_ip_id" {
  type = string
  default = null
}

variable "custom_image_id" {
  type    = string
  default = null
}

variable "publisher" {
  type    = string
  default = "Canonical"
}

variable "offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}

variable "sku" {
  type    = string
  default = "22_04-lts-gen2"
}

variable "image_version" {
  type    = string
  default = "latest"
}