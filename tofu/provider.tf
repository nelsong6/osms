terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "infra"
    storage_account_name = "nelsontofu"
    container_name       = "tfstate"
    key                  = "osms.tfstate"
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

provider "azuread" {}
