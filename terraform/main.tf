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

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}

 # comment
