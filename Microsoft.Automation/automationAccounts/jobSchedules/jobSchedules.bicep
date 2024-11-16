//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/microsoft.automation/automationaccounts/jobschedules?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of Azure Automation Account Name.')
param automationAccountName string

@description('Name of the runbook to which the schedule is associated.')
param runbookName string
@description('Name of the schedule to be linked.')
param scheduleName string

@description('Parameters required for job execution.')
param parameters object = {}
@description(' the hybrid worker group that the scheduled job should run on.')
param runOn string?


// --------------------------------------------------------------------------------
// Variables
// --------------------------------------------------------------------------------
@description('The resource name')
var _jobScheduleName = guid(automationAccountName, runbookName, scheduleName, subscription().subscriptionId, resourceGroup().id)


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Azure Automation JobSchedule.')
resource jobSchedules 'Microsoft.Automation/automationAccounts/jobSchedules@2023-11-01' = {
  name: '${automationAccountName}/${_jobScheduleName}'
  properties: {
    parameters: parameters
    runbook: {
      name: runbookName
    }
    runOn: runOn
    schedule: {
      name: scheduleName
    }
  }
}


// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource Id.')
output resourceId string = jobSchedules.id
@description('Resource name')
output name string = jobSchedules.name
