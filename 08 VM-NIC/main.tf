data "azurerm_subnet" "lookup" {

  count = var.subnet_id == null ? 1 : 0

  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "lookup" {
  count               = local.resolved_public_ip_name != null && local.resolved_public_ip_name != "" ? 1 : 0
  name                = local.resolved_public_ip_name
  resource_group_name = var.resource_group_name
}

locals {

  effective_subnet_id = (
    var.subnet_id != null
      ? var.subnet_id
      : data.azurerm_subnet.lookup[0].id
  )

  effective_public_ip_id = (
    var.public_ip_id != null
      ? var.public_ip_id
      : (var.public_ip_name != "" ? data.azurerm_public_ip.lookup[0].id : null)
  )

  resolved_public_ip_name = (
    var.public_ip_id != null
      ? regex("publicIPAddresses/([^/]+)$", var.public_ip_id)[0]
      : var.public_ip_name
  )
}

resource "azurerm_network_interface" "this" {

  name                = var.nic_name

  location            = var.location

  resource_group_name = var.resource_group_name

  tags = var.tags

  ip_configuration {

    name = "ipconfig1"

    subnet_id = local.effective_subnet_id

    private_ip_address_allocation = var.private_ip_address_allocation

    private_ip_address = (
      var.private_ip_address_allocation == "Static"
      ? var.private_ip_address
      : null
    )

    public_ip_address_id = local.effective_public_ip_id
  }
}