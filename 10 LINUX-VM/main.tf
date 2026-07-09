data "azurerm_network_interface" "lookup" {

  count = var.nic_id == null ? 1 : 0

  name                = var.nic_name
  resource_group_name = var.resource_group_name
}

locals {

  effective_nic_id = (
    var.nic_id != null
      ? var.nic_id
      : data.azurerm_network_interface.lookup[0].id
  )

}

resource "azurerm_linux_virtual_machine" "this" {

  name                = var.vm_name

  location            = var.location

  resource_group_name = var.resource_group_name

  zone = var.availability_zone

  size = var.vm_size

  admin_username = var.admin_username

  network_interface_ids = [
    local.effective_nic_id
  ]

  disable_password_authentication = var.authentication_type == "ssh"

  admin_password = (
    var.authentication_type == "password"
    ? var.admin_password
    : null
  )

  dynamic "admin_ssh_key" {

    for_each = var.authentication_type == "ssh" ? [1] : []

    content {

      username = var.admin_username

      public_key = var.ssh_public_key

    }

  }

  os_disk {

    caching = var.os_disk_caching

    storage_account_type = var.os_disk_storage_account_type

  }

  dynamic "source_image_reference" {

    for_each = var.custom_image_id == null ? [1] : []

    content {

      publisher = var.publisher

      offer = var.offer

      sku = var.sku

      version = var.image_version

    }

  }

  source_image_id = var.custom_image_id

  tags = var.tags
}

data "azurerm_network_interface" "effective" {
  name                = split("/", azurerm_linux_virtual_machine.this.network_interface_ids[0])[8]
  resource_group_name = var.resource_group_name
}