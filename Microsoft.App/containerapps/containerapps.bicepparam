using './containerapps.bicep'

param containerappName = ''
param containerappLocation = ''
param tags = {}
param managedIdentity = {
  type: 'SystemAssigned'
}
param ingress = {
  external: true
  targetPort: 80
}
param registryServer = ''
param registries = [
  {
    identity: managedIdentity.type == 'SystemAssigned' ? 'system' : managedIdentity.type
    server: registryServer
  }
]
param containers = [
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
param environmentId = ''
param workloadProfileName = 'Consumption'

