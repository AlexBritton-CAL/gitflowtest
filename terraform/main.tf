terraform {
  backend "azurerm" {
    container_name = "tfstate"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}

