resource_group_name = "agentic_ai-dev"
location            = "East US"

create_subnet_nsg = true
subnet_nsg_name = "nsg-subnet"
subnet_names = {
  agentic_ai-subnet    = "agentic_ai-subnet"
}
vnet_name            = "agentic_ai-vnet" 
#subnet_ids = {
#  app-subnet   = "/subscriptions/xxxx/resourceGroups/my-rg/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/app-subnet"
#  analytics-subnet = "/subscriptions/xxxx/resourceGroups/my-rg/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/analytics-subnet"
#}


create_nic_nsg    = false
nic_nsg_name    = "nsg-nic1"
#nic_ids = {app-nic = "/subscriptions/.../resourceGroups/my-rg/providers/Microsoft.Network/networkInterfaces/app-nic"}
nic_names = {agentic-vm-nic = "agentic-vm-nic"}

tags = {
  environment = "Production"
  managed_by  = "Ai-Agent"
}

subnet_nsg_security_rules = [
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

nic_nsg_security_rules = [
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
  }
]

