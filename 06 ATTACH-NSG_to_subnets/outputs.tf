output "associated_subnet_ids" {

  description = "Subnet IDs associated with the NSG."

  value = local.effective_subnet_ids
}

output "network_security_group_id" {

  description = "NSG used for association."

  value = local.effective_nsg_id
}