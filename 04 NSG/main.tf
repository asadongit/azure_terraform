resource "azurerm_network_security_group" "subnet_nsg" {
  count = var.create_subnet_nsg ? 1 : 0

  name                = var.subnet_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = var.subnet_nsg_security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      description                = security_rule.value.description
    }
  }
}

resource "azurerm_network_security_group" "nic_nsg" {
  count = var.create_nic_nsg ? 1 : 0

  name                = var.nic_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = var.nic_nsg_security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      description                = security_rule.value.description
    }
  }
}

data "azurerm_subnet" "lookup" {
  for_each = var.subnet_names
  name                 = each.value
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_network_interface" "lookup" {
  for_each            = var.nic_names
  name                = each.value
  resource_group_name = var.resource_group_name
}

locals {
  effective_subnet_associations = merge(
    var.subnet_ids,
    { for k, v in data.azurerm_subnet.lookup : k => v.id }
  )

  effective_nic_associations = merge(
    var.nic_ids,
    { for k, v in data.azurerm_network_interface.lookup : k => v.id }
  )
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.create_subnet_nsg ? local.effective_subnet_associations : {}

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.subnet_nsg[0].id
}

resource "azurerm_network_interface_security_group_association" "this" {
  for_each = var.create_nic_nsg ? local.effective_nic_associations : {}
  network_interface_id      = each.value
  network_security_group_id = azurerm_network_security_group.nic_nsg[0].id
}

