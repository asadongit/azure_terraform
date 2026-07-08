variable "resource_group_name" {
  description = "Name of the pre-existing resource group the NSG(s) will be created in."
  type        = string
}

variable "location" {
  description = "Azure region for the NSG(s), e.g. 'centralindia', 'eastus'."
  type        = string
}

variable "tags" {
  description = "Tags applied to every resource this module creates."
  type        = map(string)
  default     = {}
}

variable "create_subnet_nsg" {
  description = "Whether to create an NSG intended for subnet association."
  type        = bool
  default     = false
}

variable "subnet_nsg_name" {
  description = "Name of the subnet-level NSG. Required if create_subnet_nsg = true."
  type        = string
  default     = null
}

variable "subnet_ids" {
  type    = map(string)
  default = {}
}

variable "subnet_names" {
  type    = map(string)
  default = {}
}

variable "vnet_name" {
  type    = string
  default = ""
  description = "vnet name is compulsory if subnet name is used"
}

variable "create_nic_nsg" {
  description = "Whether to create an NSG intended for NIC association."
  type        = bool
  default     = false
}

variable "nic_nsg_name" {
  description = "Name of the NIC-level NSG. Required if create_nic_nsg = true."
  type        = string
  default     = null
}

variable "nic_ids" {
  type    = map(string)
  default = {}
}

variable "nic_names" {
  type    = map(string)
  default = {}
}

variable "subnet_nsg_security_rules" {
  description = "List of security rules for the subnet NSG. Leave empty to create the NSG with no custom rules (Azure default rules still apply)."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string # "Inbound" or "Outbound"
    access                     = string # "Allow" or "Deny"
    protocol                   = string # "Tcp", "Udp", "Icmp", "*"
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string, "*")
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
    description                = optional(string, null)
  }))
  default = []

  validation {
    condition     = alltrue([for r in var.subnet_nsg_security_rules : contains(["Inbound", "Outbound"], r.direction)])
    error_message = "Each rule's direction must be \"Inbound\" or \"Outbound\"."
  }

  validation {
    condition     = alltrue([for r in var.subnet_nsg_security_rules : contains(["Allow", "Deny"], r.access)])
    error_message = "Each rule's access must be \"Allow\" or \"Deny\"."
  }

  validation {
    condition     = alltrue([for r in var.subnet_nsg_security_rules : r.priority >= 100 && r.priority <= 4096])
    error_message = "Rule priority must be between 100 and 4096."
  }
}

variable "nic_nsg_security_rules" {
  description = "List of security rules for the NIC NSG. Leave empty to create the NSG with no custom rules (Azure default rules still apply)."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string, "*")
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
    description                = optional(string, null)
  }))
  default = []

  validation {
    condition     = alltrue([for r in var.nic_nsg_security_rules : contains(["Inbound", "Outbound"], r.direction)])
    error_message = "Each rule's direction must be \"Inbound\" or \"Outbound\"."
  }

  validation {
    condition     = alltrue([for r in var.nic_nsg_security_rules : contains(["Allow", "Deny"], r.access)])
    error_message = "Each rule's access must be \"Allow\" or \"Deny\"."
  }

  validation {
    condition     = alltrue([for r in var.nic_nsg_security_rules : r.priority >= 100 && r.priority <= 4096])
    error_message = "Rule priority must be between 100 and 4096."
  }
}
