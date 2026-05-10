data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}

data "azurerm_resource_group" "main" {
  name = "infra"
}

data "azurerm_key_vault" "main" {
  name                = "romaine-kv"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "terraform_remote_state" "infra_bootstrap" {
  backend = "azurerm"

  config = {
    resource_group_name  = "infra"
    storage_account_name = "nelsontofu"
    container_name       = "tfstate"
    key                  = "infra-bootstrap.tfstate"
    subscription_id      = data.azurerm_client_config.current.subscription_id
    tenant_id            = data.azurerm_client_config.current.tenant_id
    client_id            = data.azurerm_client_config.current.client_id
  }
}

locals {
  aks_oidc_issuer_url = data.terraform_remote_state.infra_bootstrap.outputs.aks_oidc_issuer_url
}
