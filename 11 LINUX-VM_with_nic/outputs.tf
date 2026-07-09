output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}

output "effective_public_ip_id" {
  description = "The public IP ID actually attached (created, resolved-by-name, or passed-through id). Null if none."
  value       = local.effective_public_ip_id
}

output "private_ip_address" {
  description = "The private IP address assigned to the NIC"
  value       = azurerm_network_interface.nic.private_ip_address
}