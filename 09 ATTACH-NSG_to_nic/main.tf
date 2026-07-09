data "azurerm_network_security_group" "lookup" {

  count = var.nsg_id == null ? 1 : 0

  name                = var.nsg_name
  resource_group_name = var.resource_group_name
}

data "azurerm_network_interface" "lookup" {

  for_each = length(var.nic_ids) == 0 ? var.nic_names : []

  name                = each.value
  resource_group_name = var.resource_group_name
}

locals {
  effective_nsg_id = var.nsg_id != null ? var.nsg_id : data.azurerm_network_security_group.lookup[0].id

  effective_nic_ids = concat(
    tolist(var.nic_ids),
    [for nic in data.azurerm_network_interface.lookup : nic.id]
  )
}

resource "azurerm_network_interface_security_group_association" "this" {

  for_each = toset(local.effective_nic_ids)

  network_interface_id = each.value

  network_security_group_id = local.effective_nsg_id
}