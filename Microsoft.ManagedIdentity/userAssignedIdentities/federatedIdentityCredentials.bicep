//
// Reference: https://learn.microsoft.com/en-us/azure/templates/microsoft.managedidentity/userassignedidentities/federatedidentitycredentials?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Federation credential name')
param federatedIdentityCredentialName string
@description('Resource name of User Assigned Identity.')
param userAssignedIdentityName string
@description('The list of audiences that can appear in the issued token.')
param audiendes string[]
@description('The URL of the issuer to be trusted.')
param issuer string
@description('The identifier of the external identity.')
param subjedt string


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
resource federatedIdentityCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  name: '${userAssignedIdentityName}/${federatedIdentityCredentialName}'
  properties: {
    audiences: audiendes
    issuer: issuer
    subject: subjedt
  }
}


