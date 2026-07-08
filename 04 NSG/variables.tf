variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "nsg_name" {
  description = "Network Security Group Name"
  type        = string
}

variable "tags" {
  description = "Tags applied to the NSG."
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "Optional: resource ID of a subnet to associate this NSG with. Leave as null to skip association."
  type        = string
  default     = null
}

variable "network_interface_id" {
  description = "Optional: resource ID of a network interface to associate this NSG with. Leave as null to skip association."
  type        = string
  default     = null
}

variable "security_rules" {
  description = "List of inbound/outbound security rules for the NSG."
  type = list(object({
    name                        = string
    priority                    = number # 100-4096, lower = evaluated first
    direction                   = string # "Inbound" or "Outbound"
    access                      = string # "Allow" or "Deny"
    protocol                    = string # "Tcp", "Udp", "Icmp", or "*"
    source_port_range           = string # e.g. "*"
    destination_port_range      = string # e.g. "443", "1521"
    source_address_prefix       = string # e.g. "*", "Internet", or a CIDR
    destination_address_prefix  = string # e.g. "*" or a CIDR
    description                 = optional(string, "")
  }))

  validation {
    condition     = alltrue([for r in var.security_rules : contains(["Inbound", "Outbound"], r.direction)])
    error_message = "Each rule's direction must be \"Inbound\" or \"Outbound\"."
  }

  validation {
    condition     = alltrue([for r in var.security_rules : contains(["Allow", "Deny"], r.access)])
    error_message = "Each rule's access must be \"Allow\" or \"Deny\"."
  }

  validation {
    condition     = alltrue([for r in var.security_rules : r.priority >= 100 && r.priority <= 4096])
    error_message = "Rule priority must be between 100 and 4096."
  }
}
