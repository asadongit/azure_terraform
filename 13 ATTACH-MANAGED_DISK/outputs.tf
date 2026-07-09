output "virtual_machine_id" {

  value = local.effective_vm_id

}

output "managed_disk_id" {

  value = local.effective_managed_disk_id

}

output "lun" {

  value = var.lun

}