data "azurerm_virtual_machine" "vm" {

  count = var.vm_id == null ? 1 : 0

  name                = var.vm_name
  resource_group_name = var.resource_group_name

}

locals {

  effective_vm_id = (
    var.vm_id != null
    ? var.vm_id
    : data.azurerm_virtual_machine.vm[0].id
  )

}

resource "azurerm_virtual_machine_run_command" "extend_lvm" {
  name                = "extend_lvm"
  location            = var.location
  virtual_machine_id  = local.effective_vm_id

  source {
    script = file("${path.module}/extend-lvm.sh")
  }

  parameter {
    name  = "LUN"
    value = var.data_disk_lun
  }

  parameter {
    name  = "VG_NAME"
    value = var.vg_name
  }

  parameter {
    name  = "LV_NAME"
    value = var.lv_name
  }

  parameter {
    name  = "MOUNT_POINT"
    value = var.mount_point
  }

}

