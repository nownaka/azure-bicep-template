//
// https://learn.microsoft.com/ja-jp/azure/templates/microsoft.operationalinsights/workspaces?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of Log Analytics Workspace.')
param workspaceName string
@description('Resource deployment region.')
param workspaceLocation string
@description('Resource tags.')
param tags object = {}

@description('The SKU of the workspace.')
@allowed([
  'CapacityReservation'
  'Free'
  'LACluster'
  'PerGB2018'
  'PerNode'
  'Premium'
  'Standalone'
  'Standard'])
param workspaceSkuName string = 'Free'


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Log Analytics Workspace.')
resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: workspaceName
  location: workspaceLocation
  tags: tags
  properties: {
    sku: {
      name: workspaceSkuName
    }
  }
}

// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource name of Log Analytics Workspace.')
output workspaceName string = workspace.name
@description('Resource Id of Log Analytics Workspace.')
output resourceId string = workspace.id
