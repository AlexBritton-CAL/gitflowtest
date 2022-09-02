terraform {
  backend "azurerm" {
    container_name = "tfstate"
    key = "gitflowtestPROD.tfstate"
    storage_account_name = "terraformstateab2021"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}

