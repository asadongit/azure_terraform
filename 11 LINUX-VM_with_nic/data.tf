# Only invoked when public_ip_input was given as a plain name (not a
# resource ID) — see locals.tf for the detection logic.

data "azurerm_public_ip" "existing" {
  count               = var.create_public_ip == false && var.public_ip_input != null && !local.public_ip_input_is_id ? 1 : 0
  name                = var.public_ip_input
  resource_group_name = coalesce(var.public_ip_resource_group_name, var.resource_group_name)
}

data "azurerm_subnet" "lookup" {

  count = var.subnet_id == null ? 1 : 0

  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}