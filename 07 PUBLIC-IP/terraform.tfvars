public_ip_name = "vm01-public-ip"

resource_group_name = "agentic_ai-dev"

location = "East US"

sku = "Standard"

allocation_method = "Static"

tags = {
  Environment = "Dev"
  Owner       = "AI-Agent"
}