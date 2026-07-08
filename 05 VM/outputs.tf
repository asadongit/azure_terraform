output "private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "public_ip" {
  value = local.effective_public_ip_id != null ? azurerm_public_ip.public_ip[0].ip_address : null
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}