provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  address_space       = var.address_space
  tags                = var.tags
}

