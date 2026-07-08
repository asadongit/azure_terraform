resource_group_name = "agentic_ai-dev"
location            = "East US"

vm_name         = "agentic-vm"
vm_size         = "Standard_D2als_v7"
admin_username  = "agenticai"

# Options: ssh | password
authentication_type = "ssh"

# Used only if authentication_type = "password"
admin_password = null

# Used only if authentication_type = "ssh"
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMTuK2v6a+59mtzAd2S/a/NlhVhDD/FId2rSFqyLgXm5 agentic-vm"

subnet_id = "/subscriptions/9f7df4c2-61e5-47f6-a9d9-dc9f0bd559ab/resourceGroups/agentic_ai-dev/providers/Microsoft.Network/virtualNetworks/agentic_ai-vnet/subnets/agentic_ai-subnet"
#public_ip_id = "/subscriptions/9f7df4c2-61e5-47f6-a9d9-dc9f0bd559ab/resourceGroups/agentic_ai-dev/providers/Microsoft.Network/publicIPAddresses/agentic_ai-pip"

create_public_ip = true
availability_zone = "2"
# Leave as null to use a Marketplace image.
# Set this to use a Custom Image.
custom_image_id = null

# Marketplace Image (used only when custom_image_id = null)
publisher     = "Canonical"
offer         = "0001-com-ubuntu-server-jammy"
sku           = "22_04-lts-gen2"
image_version = "latest"