resource "azuread_application" "grafana" {
  display_name     = "Grafana"
  sign_in_audience = "AzureADandPersonalMicrosoftAccount"

  owners = [data.azuread_client_config.current.object_id]

  api {
    requested_access_token_version = 2
  }

  web {
    redirect_uris = [
      "https://grafana.romaine.life/",
      "https://grafana.romaine.life/login/azuread",
      "https://grafana.romaine.life/login/generic_oauth",
      "https://grafana.romaine.life/oauth2/callback",
    ]
  }

  optional_claims {
    id_token {
      name = "email"
    }
  }
}

resource "azuread_application_password" "grafana" {
  application_id = azuread_application.grafana.id
  display_name   = "grafana-azuread"
}

resource "random_password" "grafana_admin" {
  length  = 32
  special = false
}

resource "random_password" "grafana_oauth2_proxy_cookie" {
  length  = 32
  special = false
}

resource "azurerm_key_vault_secret" "grafana_oauth_client_id" {
  name         = "grafana-oauth-client-id"
  value        = azuread_application.grafana.client_id
  key_vault_id = data.azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "grafana_oauth_client_secret" {
  name         = "grafana-oauth-client-secret"
  value        = azuread_application_password.grafana.value
  key_vault_id = data.azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "grafana_oauth_allowed_emails" {
  name         = "grafana-oauth-allowed-emails"
  value        = join("\n", [for email in var.grafana_allowed_emails : lower(trimspace(email))])
  key_vault_id = data.azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "grafana_oauth_role_attribute_path" {
  name = "grafana-oauth-role-attribute-path"
  value = format(
    "contains([%s], email) && 'Admin' || contains([%s], preferred_username) && 'Admin' || contains([%s], upn) && 'Admin' || ''",
    join(", ", [for email in var.grafana_allowed_emails : format("'%s'", lower(trimspace(email)))]),
    join(", ", [for email in var.grafana_allowed_emails : format("'%s'", lower(trimspace(email)))]),
    join(", ", [for email in var.grafana_allowed_emails : format("'%s'", lower(trimspace(email)))]),
  )
  key_vault_id = data.azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "grafana_oauth_cookie_secret" {
  name         = "grafana-oauth-cookie-secret"
  value        = random_password.grafana_oauth2_proxy_cookie.result
  key_vault_id = data.azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "grafana_admin_password" {
  name         = "grafana-admin-password"
  value        = random_password.grafana_admin.result
  key_vault_id = data.azurerm_key_vault.main.id

  lifecycle {
    ignore_changes = [value]
  }
}

output "grafana_client_id" {
  value       = azuread_application.grafana.client_id
  description = "Entra application client ID for Grafana AzureAD login."
}
