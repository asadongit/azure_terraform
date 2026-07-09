output "rule_ids" {

  description = "IDs of created NSG rules."

  value = {
    for name, rule in azurerm_network_security_rule.this :
    name => rule.id
  }
}