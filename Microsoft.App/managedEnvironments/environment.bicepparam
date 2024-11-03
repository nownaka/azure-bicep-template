using './environment.bicep'

param environmentName = ''
param environmentLocation = ''
param tags = {}
param workspaceName = ''
param workloadProfiles = [
  {
    name: 'Consumption'
    workloadProfileType: 'Consumption'
  }
]

