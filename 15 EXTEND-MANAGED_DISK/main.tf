data "azurerm_managed_disk" "this" {
  name                = var.disk_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_managed_disk" "data_disk" {
  name                 = var.disk_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  zone                 = var.availability_zone
  tags                 = var.tags
}

import {
  to = azurerm_managed_disk.data_disk
  id = data.azurerm_managed_disk.this.id
}

