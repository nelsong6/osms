import {
  to = azurerm_storage_account.loki
  id = "/subscriptions/aee0cbd2-8074-4001-b610-0f8edb4eaa3c/resourceGroups/infra/providers/Microsoft.Storage/storageAccounts/romainelokilogs"
}

import {
  to = azurerm_storage_container.loki["loki-admin"]
  id = "/subscriptions/aee0cbd2-8074-4001-b610-0f8edb4eaa3c/resourceGroups/infra/providers/Microsoft.Storage/storageAccounts/romainelokilogs/blobServices/default/containers/loki-admin"
}

import {
  to = azurerm_storage_container.loki["loki-chunks"]
  id = "/subscriptions/aee0cbd2-8074-4001-b610-0f8edb4eaa3c/resourceGroups/infra/providers/Microsoft.Storage/storageAccounts/romainelokilogs/blobServices/default/containers/loki-chunks"
}

import {
  to = azurerm_storage_container.loki["loki-ruler"]
  id = "/subscriptions/aee0cbd2-8074-4001-b610-0f8edb4eaa3c/resourceGroups/infra/providers/Microsoft.Storage/storageAccounts/romainelokilogs/blobServices/default/containers/loki-ruler"
}

import {
  to = azurerm_user_assigned_identity.loki
  id = "/subscriptions/aee0cbd2-8074-4001-b610-0f8edb4eaa3c/resourceGroups/infra/providers/Microsoft.ManagedIdentity/userAssignedIdentities/loki-identity"
}

import {
  to = azurerm_federated_identity_credential.loki
  id = "/subscriptions/aee0cbd2-8074-4001-b610-0f8edb4eaa3c/resourceGroups/infra/providers/Microsoft.ManagedIdentity/userAssignedIdentities/loki-identity/federatedIdentityCredentials/aks-cluster-loki"
}

import {
  to = azurerm_role_assignment.loki_storage_blob_contributor
  id = "/subscriptions/aee0cbd2-8074-4001-b610-0f8edb4eaa3c/resourceGroups/infra/providers/Microsoft.Storage/storageAccounts/romainelokilogs/providers/Microsoft.Authorization/roleAssignments/9327737eefa69cd3abe3ae8d2e6c6130"
}

import {
  to = azurerm_key_vault_secret.grafana_admin_password
  id = "https://romaine-kv.vault.azure.net/secrets/grafana-admin-password/3281e7fb9ca54dd0ba874d245673a909"
}
