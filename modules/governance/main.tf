resource "azurerm_resource_group_policy_assignment" "allowed_vm_skus" {
  name                 = "allowed-vm-sizes"
  resource_group_id    = var.resource_group_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3"

  parameters = jsonencode({
    listOfAllowedSKUs = { value = ["Standard_B2ats_v2", "Standard_B2s", "Standard_D2s_v3"] }
  })
}


resource "azurerm_storage_management_policy" "lifecycle" {
  storage_account_id = azurerm_storage_account.this.id

  rule {
    name    = "move-to-cool"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 30
        tier_to_archive_after_days_since_creation_greater_than = 90
        delete_after_days_since_modification_greater_than          = 365
      }
    }
  }
}