//
// Reference: https://learn.microsoft.com/en-us/azure/templates/microsoft.app/managedenvironments?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of Azure Container Apps Environment.')
param environmentName string
@description('Resource deployment region.')
param environmentLocation string
@description('Resource tags.')
param tags object = {}

@description('Resource name of Log Analytics Workspace.')
param workspaceName string
@description('Workload profiles configured for the Managed Environment.')
param workloadProfiles { name: string, workloadProfileType: string}[] = [
  {
    name: 'Consumption'
    workloadProfileType: 'Consumption'
  }
]


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Azure Container Apps Environment.')
resource environment 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: environmentName
  location: environmentLocation
  tags: tags
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: reference('Microsoft.OperationalInsights/workspaces/${workspaceName}', '2020-08-01').customerId
        sharedKey: listKeys('Microsoft.OperationalInsights/workspaces/${workspaceName}', '2020-08-01').primarySharedKey
      }
    }
    workloadProfiles: workloadProfiles
  }
}


// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource Id of Azure Container Apps Environment.')
output resourceId string = environment.id
