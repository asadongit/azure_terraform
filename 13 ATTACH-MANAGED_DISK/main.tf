data "azurerm_virtual_machine" "vm" {

  count = var.vm_id == null ? 1 : 0
  name                = var.vm_name
  resource_group_name = var.resource_group_name  
}

data "azurerm_managed_disk" "disk" {

  count = var.managed_disk_id == null ? 1 : 0

  name                = var.managed_disk_name
  resource_group_name = var.resource_group_name

}

locals {

  effective_vm_id = (
    var.vm_id != null
      ? var.vm_id
      : data.azurerm_virtual_machine.vm[0].id
  )

  effective_managed_disk_id = (
    var.managed_disk_id != null
      ? var.managed_disk_id
      : data.azurerm_managed_disk.disk[0].id
  )

}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {

  managed_disk_id = local.effective_managed_disk_id

  virtual_machine_id = local.effective_vm_id

  lun = var.lun

  caching = var.caching

  write_accelerator_enabled = var.write_accelerator_enabled

}