data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.existing.location #using data source but not variable directly to make sure 
  resource_group_name = data.azurerm_resource_group.existing.name     #the virtual network is created only if the resource group exists
  address_space       = var.address_space
  tags                = var.tags
}

