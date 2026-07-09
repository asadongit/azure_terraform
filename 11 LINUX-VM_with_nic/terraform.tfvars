vm_name              = "app01"
location             = "eastus"
resource_group_name  = "agentic_ai-dev"
vnet_name = "agentic_ai-vnet"
subnet_name = "agentic_ai-subnet"
availability_zone    = "1"
vm_size              = "Standard_D2ls_v7"
admin_username       = "azureadmin"
authentication_type  = "ssh"
ssh_public_key       = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMTuK2v6a+59mtzAd2S/a/NlhVhDD/FId2rSFqyLgXm5 agentic-vm"

publisher     = "Canonical"
offer         = "0001-com-ubuntu-server-jammy"
sku           = "22_04-lts-gen2"
image_version = "latest"

# ---- Public IP: reuse an existing one, referenced by NAME ----
create_public_ip              = false
#public_ip_input               = "pip-app01-existing"
#public_ip_resource_group_name = "agentic_ai-dev"