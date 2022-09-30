terraform {
  backend "azurerm" {
    # container_name = "tfstate"
    # storage_account_name = "terraformstateab2021"
    # key = "Test_Linux_VM.tfstate"
  }
}

provider "azurerm" {
    #features = {}
    features {}
}

