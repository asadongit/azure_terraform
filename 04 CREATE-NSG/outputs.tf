output "nsg_id" {
  description = "Resource ID of the created NSG."

  value = azurerm_network_security_group.this.id
}

output "nsg_name" {
  description = "Name of the created NSG."

  value = azurerm_network_security_group.this.name
}

output "resource_group_name" {
  description = "Resource Group containing the NSG."

  value = azurerm_network_security_group.this.resource_group_name
}