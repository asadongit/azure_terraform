variable "resource_group_name" {

  description = "Resource Group of the NSG (required only when nsg_name is used)."

  type = string

  default = null
}

variable "nsg_name" {

  description = "Existing NSG name."

  type = string

  default = null
}

variable "nsg_id" {

  description = "Existing NSG ID."

  type = string

  default = null
}

variable "security_rules" {

  description = "Security rules to create."

  type = map(object({

    priority  = number
    direction = string
    access    = string
    protocol  = string

    source_port_range          = string
    destination_port_range     = string

    source_address_prefix      = string
    destination_address_prefix = string

    description = optional(string, "")

  }))

}