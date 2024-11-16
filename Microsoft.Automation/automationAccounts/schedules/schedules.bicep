//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/microsoft.automation/automationaccounts/schedules?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Resource name of Azure Automation Account Name.')
param automationAccountName string

@description('Name of the schedule to be set')
param scheduleName string

@description('the AdvancedSchedule.')
param advancedSchedule object?
@description('The description of the schedule.')
param scheduleDescription string?
@description('The end time of the schedule.')
param expiryTime string?
@description('The frequency of the schedule.')
@allowed([
  'Day'
  'Hour'
  'Minute'
  'Month'
  'OneTime'
  'Week' 
])
param frequency string
@description('The interval of the schedule.  Example: yyyy-MM-ddTHH:mm:ss+09:00')
param interval int
@description('The start time of the schedule. Example: yyyy-MM-ddTHH:mm:ss+09:00')
param startTime string
@description(' The time zone of the schedule.')
param timeZone string = 'Asia/Tokyo'


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Azure Automation Schedule.')
resource schedule 'Microsoft.Automation/automationAccounts/schedules@2023-11-01' = {
  name: '${automationAccountName}/${scheduleName}'
  properties: {
    advancedSchedule: advancedSchedule
    description: scheduleDescription
    expiryTime: expiryTime
    frequency: frequency
    interval: any(interval)
    startTime: startTime
    timeZone: timeZone
  }
}

// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource Id.')
output resourceId string = schedule.id
@description('Resource name')
output name string = schedule.name
