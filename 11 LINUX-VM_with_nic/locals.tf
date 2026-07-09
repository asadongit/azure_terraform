locals {
  # An Azure resource ID always starts with /subscriptions/... — a plain
  # name never does. This one check lets public_ip_input accept a "name"
  # or an "id" interchangeably.

  #we could have done a data source lookup for the public IP as well because the resource is of already existing nature, but we are not doing that here because it will fail if the public IP is in a different resource group than the one we are creating the NIC in. So we are just checking if the input is an ID or not and then using that to determine how to resolve the public IP ID.
  public_ip_input_is_id = var.public_ip_input != null ? can(regex("^/subscriptions/", var.public_ip_input)) : false

  # Resolve the public IP ID that actually gets attached to the NIC.
  # Priority: created resource > id passed as-is > name resolved via data source.
  effective_public_ip_id = (
    var.create_public_ip ? azurerm_public_ip.public_ip[0].id :
    var.public_ip_input == null ? null :
    local.public_ip_input_is_id ? var.public_ip_input :
    data.azurerm_public_ip.existing[0].id
  )

  effective_subnet_id = (
    var.subnet_id != null
      ? var.subnet_id
      : data.azurerm_subnet.lookup[0].id
  )
}
