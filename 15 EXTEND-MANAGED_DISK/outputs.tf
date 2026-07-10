output "disk_id" {
  value = azurerm_managed_disk.data_disk.id
}

output "disk_size_gb" {
  value = azurerm_managed_disk.data_disk.disk_size_gb
}

output "current_disk_size_gb" {
  value = data.azurerm_managed_disk.this.disk_size_gb
}