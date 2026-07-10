resource_group_name   = "agentic_ai-dev"
location               = "eastus"
disk_name              = "vm01-data-disk"
storage_account_type  = "Standard_LRS"
disk_size_gb           = 42
availability_zone = "2"

tags = {
  Environment = "Dev"
}