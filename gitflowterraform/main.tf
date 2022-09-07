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
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "example1" {
  name                 = "example-subnet1"
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = local.config.subnet1
  private_link_service_network_policies_enabled = true
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "example2" {
  name                 = "example-subnet2"
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = local.config.subnet2
  private_link_service_network_policies_enabled = true
  enforce_private_link_endpoint_network_policies = false
}