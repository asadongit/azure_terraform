data "azurerm_network_security_group" "lookup" {

  count = var.nsg_id == null ? 1 : 0

  name                = var.nsg_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "lookup" {

  for_each = length(var.subnet_ids) == 0 ? var.subnet_names : []

  name                 = each.value
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

locals {

  effective_nsg_id = (
    var.nsg_id != null
      ? var.nsg_id
      : data.azurerm_network_security_group.lookup[0].id
  )

  effective_subnet_ids = concat(

    tolist(var.subnet_ids),

    [for subnet in data.azurerm_subnet.lookup : subnet.id]

  )
}

resource "azurerm_subnet_network_security_group_association" "this" {

  for_each = toset(local.effective_subnet_ids)

  subnet_id = each.value

  network_security_group_id = local.effective_nsg_id
}