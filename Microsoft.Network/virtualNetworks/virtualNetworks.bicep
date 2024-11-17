//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/microsoft.network/virtualnetworks?pivots=deployment-language-bicep
// Created by nownaka.
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of Virtual Network.')
param virtualNetworkName string
@description('Resource deployment region.')
param virtualNetworkLocation string = resourceGroup().location
@description('Resource tags.')
param tags object = {}

@description('A list of address blocks reserved for this virtual network in CIDR notation.')
param addressSpace {
  addressPrefixes: string[]
}
@description('Indicates if DDoS protection is enabled for all the protected resources in the virtual network. It requires a DDoS protection plan associated with the resource.')
param enableDdosProtection bool = false
@description('Indicates if encryption is enabled on virtual network and if VM without encryption is allowed in encrypted VNet.')
param encryption {
  enabled: bool
  enforcement: 'AllowUnencrypted' | 'DropUnencrypted'
} = {
  enabled: false
  enforcement: 'AllowUnencrypted'
}
@description('A list of subnets in a Virtual Network.')
param subnets object[] = []
@description('A list of peerings in a Virtual Network.')
param virtualNetworkPeerings object[] = []

// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Virtual Networks.')
resource virtualNetworks 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: virtualNetworkName
  location: virtualNetworkLocation
  tags: tags
  properties: {
    addressSpace: addressSpace
    enableDdosProtection: enableDdosProtection
    encryption: encryption
    subnets: subnets
    virtualNetworkPeerings: virtualNetworkPeerings
  }
}

// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource Id.')
output resourceId string = virtualNetworks.id
@description('Resource name')
output name string = virtualNetworks.name
