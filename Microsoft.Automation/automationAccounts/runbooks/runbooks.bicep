//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/microsoft.automation/automationaccounts/runbooks?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of parent Azure Automation Account Name.')
param automationAccountName string

@description('Runbook name.')
param runbookName string
@description('Resource deployment region.')
param runbookLocation string
@description('Resource tags.')
param tags object = {}

@description('The description of the runbook.')
param runbookDescription string?
@description('The type of the runbook.')
@allowed([
  'Graph'
  'GraphPowerShell'
  'GraphPowerShellWorkflow'
  'PowerShell'
  'PowerShell72'
  'PowerShellWorkflow'
  'Python2'
  'Python3'
  'Script'
])
param runbookType string
@description('Verbose log option.')
param logVerbose bool = false
@description('Progress log option.')
param logProgress bool = false
@description('The activity-level tracing options of the runbook.')
param logActivityTrace int = 0
@description('The published runbook content link.')
param publishContentLink object?


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Azure Automation Runbook.')
resource runbook 'Microsoft.Automation/automationAccounts/runbooks@2023-11-01' = {
  name: '${automationAccountName}/${runbookName}'
  location: runbookLocation
  tags: tags
  properties: {
    description: runbookDescription
    runbookType: runbookType
    logVerbose: logVerbose
    logProgress: logProgress
    logActivityTrace: logActivityTrace
    publishContentLink: publishContentLink
  }
}


// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource Id.')
output resourceId string = runbook.id
@description('Resource name')
output name string = runbook.name
