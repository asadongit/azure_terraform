output "managed_disk_id" {

  description = "Managed Disk ID."

  value = azurerm_managed_disk.this.id

}

output "managed_disk_name" {

  value = azurerm_managed_disk.this.name

}

output "disk_size_gb" {

  value = azurerm_managed_disk.this.disk_size_gb

}