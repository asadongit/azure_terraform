output "association_ids" {

  value = {

    for nic, assoc in azurerm_network_interface_security_group_association.this :

    nic => assoc.id

  }

}