output "public_ip_id" {

  description = "Public IP Resource ID."

  value = azurerm_public_ip.this.id
}

output "public_ip_name" {

  description = "Public IP Name."

  value = azurerm_public_ip.this.name
}

output "ip_address" {

  description = "Allocated Public IP."

  value = azurerm_public_ip.this.ip_address
}

output "fqdn" {

  description = "FQDN if configured."

  value = azurerm_public_ip.this.fqdn
}