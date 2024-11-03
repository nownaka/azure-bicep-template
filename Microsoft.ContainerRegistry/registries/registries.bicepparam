using './registries.bicep'

param registryName = ''
param registryLocation = ''
param tags = {}
param zoneRedundancy = 'Disabled'
param registrySku = 'Basic'
param publicNetworkAccess = 'Enabled'

