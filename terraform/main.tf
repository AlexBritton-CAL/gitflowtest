terraform {
  backend "azurerm" {
    container_name = "tfstate"
    storage_account_name = "terraformstateab2021"
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

