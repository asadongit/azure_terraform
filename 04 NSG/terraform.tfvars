resource_group_name = "agentic_ai-dev"
location            = "East US"
nsg_name            = "nsg_1"
subnet_id           = "/subscriptions/9f7df4c2-61e5-47f6-a9d9-dc9f0bd559ab/resourceGroups/agentic_ai-dev/providers/Microsoft.Network/virtualNetworks/agentic_ai-vnet/subnets/agentic_ai-subnet"
#network_interface_id = "value"

tags = {
  environment = "Production"
  managed_by  = "Ai-Agent"
}

security_rules = [
  {
    name                        = "Allow-HTTPS-Inbound"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "Internet"
    destination_address_prefix  = "*"
    description                 = "Allow inbound HTTPS from Internet"
  },
  {
    name                        = "Allow-SSH-From-Bastion"
    priority                    = 110
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "10.0.1.0/24"
    destination_address_prefix  = "*"
    description                 = "Allow SSH only from bastion subnet"
  },
  {
    name                        = "Allow-Outbound-Oracle-DB"
    priority                    = 100
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "1521"
    source_address_prefix       = "*"
    destination_address_prefix  = "10.0.2.0/24"
    description                 = "Allow outbound to Oracle DB subnet"
  },
  {
    name                        = "Allow-Outbound-HTTPS"
    priority                    = 110
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "Internet"
    description                 = "Allow outbound HTTPS for updates/package installs"
  }
]