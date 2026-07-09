vm_name = "vm01"

resource_group_name = "agentic_ai-dev"

location = "East US"

vm_size = "Standard_D2als_v7"

nic_id = "/subscriptions/.../networkInterfaces/vm01-nic"

admin_username = "azureuser"

availability_zone = "2"

authentication_type = "ssh"

ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMTuK2v6a+59mtzAd2S/a/NlhVhDD/FId2rSFqyLgXm5 agentic-vm"

tags = {
  Environment = "Dev"
}