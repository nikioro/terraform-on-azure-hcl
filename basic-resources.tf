resource "azurerm_resource_group" "default_rg" {
  name = var.default_resource_group
  location = var.default_region
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_network_security_group" "default_sg" {
  name                = "default-sg"
  location            = azurerm_resource_group.default_rg.location
  #resource_group_name = var.default_resource_group
  resource_group_name = azurerm_resource_group.default_rg.name
}

resource "azurerm_virtual_network" "default_vnet" {
  name                = "default-vnet"
  location            = azurerm_resource_group.default_rg.location
  resource_group_name = azurerm_resource_group.default_rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.default_sg.id
  }

    tags = local.tags
}