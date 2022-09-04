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
  resource_group_name = azurerm_resource_group.example.name
}