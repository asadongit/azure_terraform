output "nic_id" {

  description = "NIC ID."

  value = azurerm_network_interface.this.id
}

output "nic_name" {

  description = "NIC Name."

  value = azurerm_network_interface.this.name
}

output "private_ip" {

  description = "Private IP."

  value = azurerm_network_interface.this.private_ip_address
}

output "public_ip" {
  description = "The public IP address attached to the VM"
  value       = try(data.azurerm_public_ip.lookup[0].ip_address, null)
}