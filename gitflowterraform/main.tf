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
  config_content = file("../config/${local.config_name}.yaml")
  config                = yamldecode(local.config_content)
}

data "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}

 # comment

output config {
  value = local.config
}