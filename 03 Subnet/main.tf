provider "azurerm" {
  features {}
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name  #using the rg & VNet name from data source but not from variables directly 
  virtual_network_name = data.azurerm_virtual_network.vnet.name                 #to make sure the subnet is created only if there exists a virtual network 
  address_prefixes     = var.address_prefixes                                   #with the given name and resource group.
}