//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/Microsoft.ManagedIdentity/userAssignedIdentities?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of User Assigned Identity.')
param userAssignedIdentityName string
@description('Resource deployment region.')
param userAssignedIdentityLocation string
@description('Resource tags.')
param tags object = {}


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('User Assigned Managed Identity.')
resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: userAssignedIdentityName
  location: userAssignedIdentityLocation
  tags: tags
}


// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource name of User Assigned Identity.')
output name string = userAssignedIdentity.name
@description('Resource Id of User Assigned Identity.')
output resourceId string = userAssignedIdentity.id
@description('Client App Id of User Assigned Identity.')
output clientId string = userAssignedIdentity.properties.clientId
@description('Principal Id of User Assigned Identity.')
output principalId string = userAssignedIdentity.properties.principalId
@description('Tenant Id where the User Assigned Identity resides.')
output tenantId string = userAssignedIdentity.properties.tenantId
