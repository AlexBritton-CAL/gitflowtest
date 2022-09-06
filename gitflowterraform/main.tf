terraform {
  backend "azurerm" {
    # container_name = "tfstate"
    # storage_account_name = "terraformstateab2021"
    # key = "GitFlowTestPROD.tfstate"
  }
}

provider "azurerm" {
    #features = {}
    features {}
}

locals {
  config_content = file("../config/${var.config_name}.yml")
  config                = yamldecode(local.config_content)
}

data "azurerm_resource_group" "example" {
  name     = local.config.rgname
}

resource "azurerm_private_dns_zone" "example" {
  name                = "ab${var.config_name}.local"
  resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}