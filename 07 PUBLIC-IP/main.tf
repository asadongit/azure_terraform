resource "azurerm_public_ip" "this" {

  name                = var.public_ip_name

  resource_group_name = var.resource_group_name

  location            = var.location

  sku                 = var.sku

  allocation_method   = var.allocation_method

  zones               = var.zones

  tags = var.tags
}