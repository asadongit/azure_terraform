resource "azurerm_public_ip" "public_ip" {
  count               = var.create_public_ip ? 1 : 0
  name                = "${var.vm_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.public_ip_sku
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id = local.effective_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = local.effective_public_ip_id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  zone                = var.availability_zone
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  disable_password_authentication = var.authentication_type == "ssh"
  admin_password                  = var.authentication_type == "password" ? var.admin_password : null

  dynamic "admin_ssh_key" {
    for_each = var.authentication_type == "ssh" ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.ssh_public_key
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  dynamic "source_image_reference" {
    for_each = var.custom_image_id == null ? [1] : []
    content {
      publisher = var.publisher
      offer     = var.offer
      sku       = var.sku
      version   = var.image_version
    }
  }

  source_image_id = var.custom_image_id
}
