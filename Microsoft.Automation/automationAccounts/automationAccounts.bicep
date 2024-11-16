//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/microsoft.automation/automationaccounts?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of Azure Automation Account Name.')
param automationAccountName string
@description('Resource deployment region.')
param automationAccountLocation string
@description('Resource tags.')
param tags object = {}

@description('Identity type.')
@allowed(['None', 'SystemAssigned','SystemAssigned, UserAssigned', 'UserAssigned'])
param identityTyoe string?
@description('Sets the identity property for automation account')
param identity { type: 'None' | 'SystemAssigned' | 'SystemAssigned, UserAssigned' | 'UserAssigned' | null, userAssignedIdentities: object? } = {
  type: identityTyoe
}
@description('Indicates whether requests using non-AAD authentication are blocked.')
param disableLocalAuth bool = false
@description('Indicates whether traffic on the non-ARM endpoint (Webhook/Agent) is allowed from the public internet')
param publicNetworkAccess bool = true
@description('The encryption properties for the automation account.')
param encryption { identity: object, keySource: 'Microsoft.Automation' | 'Microsoft.Keyvault', keyVaultProperties: object}?
@description('Name ofAccount SKU.')
@allowed([
  'Basic'
  'Free'
])
param skuName string = 'Free'


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Azure Automation Account.')
resource automationAccount 'Microsoft.Automation/automationAccounts@2023-11-01' = {
  name: automationAccountName
  location: automationAccountLocation
  tags: tags
  identity: identity
  properties: {
    disableLocalAuth: disableLocalAuth
    encryption: encryption
    publicNetworkAccess: publicNetworkAccess
    sku: {
      name: skuName
    }
  }
}


// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource Id.')
output resourceId string = automationAccount.id
@description('Resource name')
output name string = automationAccount.name
@description('Identity id of SystemAssigned')
output identityId string? = automationAccount.identity.principalId
