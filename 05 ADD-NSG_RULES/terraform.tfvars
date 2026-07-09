resource_group_name = "agentic_ai-dev"

nsg_name = "web-nsg"

security_rules = {

  AllowSSH = {

    priority  = 100

    direction = "Inbound"

    access    = "Allow"

    protocol  = "Tcp"

    source_port_range = "*"

    destination_port_range = "22"

    source_address_prefix = "*"

    destination_address_prefix = "*"

    description = "Allow SSH"

  }

  AllowHTTP = {

    priority  = 200

    direction = "Inbound"

    access    = "Allow"

    protocol  = "Tcp"

    source_port_range = "*"

    destination_port_range = "80"

    source_address_prefix = "*"

    destination_address_prefix = "*"

    description = "Allow HTTP"

  }

  AllowHTTPS = {

    priority  = 300

    direction = "Inbound"

    access    = "Allow"

    protocol  = "Tcp"

    source_port_range = "*"

    destination_port_range = "443"

    source_address_prefix = "*"

    destination_address_prefix = "*"

    description = "Allow HTTPS"

  }

}