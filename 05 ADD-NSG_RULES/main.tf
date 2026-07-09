data "azurerm_network_security_group" "lookup" {
  count = var.nsg_id == null ? 1 : 0
  name = var.nsg_name
  resource_group_name = var.resource_group_name
}

locals {
  effective_nsg_name = (
    var.nsg_id != null ?
    split("/", var.nsg_id)[8] :
    data.azurerm_network_security_group.lookup[0].name
  )

  effective_rg = (
    var.nsg_id != null ?
    split("/", var.nsg_id)[4] :
    data.azurerm_network_security_group.lookup[0].resource_group_name
  )
}

resource "azurerm_network_security_rule" "this" {
  for_each = var.security_rules
  name = each.key
  priority  = each.value.priority
  direction = each.value.direction
  access = each.value.access
  protocol = each.value.protocol
  source_port_range = each.value.source_port_range
  destination_port_range = each.value.destination_port_range
  source_address_prefix = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
  description = each.value.description
  network_security_group_name = local.effective_nsg_name
  resource_group_name = local.effective_rg
}