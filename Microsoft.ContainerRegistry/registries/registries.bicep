//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/microsoft.containerregistry/registries?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of Azure Container Registry.')
param registryName string
@description('Resource deployment region.')
param registryLocation string
@description('Resource tags.')
param tags object = {}

@description('Whether or not zone redundancy is enabled for this container registry.')
@allowed(['Disabled','Enabled'])
param zoneRedundancy string = 'Disabled'
@description('The SKU of the container registry.')
@allowed(['Basic', 'Classic', 'Premium', 'Standard'])
param registrySku string = 'Basic'
@description('Whether or not public network access is allowed for the container registry.')
@allowed(['Disabled', 'Enabled'])
param publicNetworkAccess string = 'Enabled'


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Azure Container Registry.')
resource registry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: registryName
  location: registryLocation
  sku: {
    name: registrySku
  }
  tags: tags
  properties: {
    publicNetworkAccess: publicNetworkAccess
    zoneRedundancy: zoneRedundancy
  }
  dependsOn: []
}


// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource id of Azure Container Registry.')
output resourceId string = registry.id
@description('Domain name of Azure Container Registry.')
output loginServer string = registry.properties.loginServer
