output "vm_id" {

  value = azurerm_linux_virtual_machine.this.id

}

output "vm_name" {

  value = azurerm_linux_virtual_machine.this.name

}

output "private_ip" {

  value = data.azurerm_network_interface.effective.private_ip_address

}