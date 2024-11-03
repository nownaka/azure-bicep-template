//
// Reference: https://learn.microsoft.com/en-us/azure/templates/microsoft.app/containerapps?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of Azure Container Apps.')
param containerappName string
@description('Resource deployment region.')
param containerappLocation string
@description('Resource tags.')
param tags object = {}

@description('Managed identities for the Container App to interact with other Azure services without maintaining any secrets or credentials in code.')
param managedIdentity { type: string, userAssignedIdentities: object? } = {
  type: 'SystemAssigned'
}
@description('Ingress configurations.')
param ingress { external: bool, targetPort: int } = {
  external: true
  targetPort: 80
}
@description('Container Registry Server.')
param registryServer string
@description('Collection of private container registry credentials for containers used by the Container app')
param registries { identity: string?, passwordSecretRef: string?, server: string?, username: string? }[] = [
  {
    identity: managedIdentity.type == 'SystemAssigned' ? 'system' : managedIdentity.type
    server: registryServer
  }
]
@description('List of container definitions for the Container App.')
param containers object[] = [
  {
    name: containerappName
    image: 'mcr.microsoft.com/k8se/quickstart:latest'  
    command: []
    args: []
    resources: {
        cpu: '0.25'
        memory: '.5Gi'
    }
  }
]
@description('Resource ID of environment.')
param environmentId string
@description('Workload profile name to pin for container app execution.')
param workloadProfileName string = 'Consumption'


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Azure Container App.')
resource containerapp 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerappName
  location: containerappLocation
  tags: tags
  identity: managedIdentity
  properties: {
    configuration: {
      ingress: ingress
      registries: registries
    }
    environmentId: environmentId
    template: {
      containers: containers
      scale: {
        minReplicas: 0
      }
    }
    workloadProfileName: workloadProfileName
  }
}


// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource Id of Azure Container App.')
output resourceId string = containerapp.id
@description('Resource name of Azure Container App.')
output name string = containerapp.name
