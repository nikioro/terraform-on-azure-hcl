terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.86.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

provider "azurerm" {
  features {
  }
    subscription_id = var.subscrition_id
    tenant_id       = var.tenant_id
}

provider "random" {
  # Configuration options
}