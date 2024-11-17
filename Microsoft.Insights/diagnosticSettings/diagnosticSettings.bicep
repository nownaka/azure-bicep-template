//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/microsoft.insights/diagnosticsettings?pivots=deployment-language-bicep#metricsettings-1
// Created by nownaka.
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Name of the scoped resource')
param scopeResourceName string
@description('')
param diagnosticSettingName string
@description('The resource Id for the event hub authorization rule.')
param eventHubAuthorizationRuleId string?
@description('The name of the event hub. If none is specified, the default event hub will be selected.')
param eventHubName string?
@description('A string indicating whether the export to Log Analytics should use the default destination type.')
@allowed(['Dedicated'])
param logAnalyticsDestinationType string?
@description('The list of logs settings.')
param logs {
  category: string?
  categoryGroup: string?
  enabled: bool
  retentionPolicy: {
    days: int
    enabled: bool
  }?
}[] = []
@description('The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.')
param marketplacePartnerId string?
@description('The list of metric settings.')
param metrics {
  category: 'string'
  enabled: bool
  retentionPolicy: {
    days: int
    enabled: bool
  }
  timeGrain: 'string'
}[] = []
@description('The service bus rule Id of the diagnostic setting. This is here to maintain backwards compatibility.')
param serviceBusRuleId string?
@description('The resource ID of the storage account to which you would like to send Diagnostic Logs.')
param storageAccountId string?
@description('The full ARM resource ID of the Log Analytics workspace to which you would like to send Diagnostic Logs. ')
param workspaceId string?


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
// Replace {resource type} according to the scoped resource.
@description('Scoped resource')
resource scope '{resource type}' existing = {
  name: scopeResourceName
}

@description('diagnosticSettings.')
resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: diagnosticSettingName
  scope: scope
  properties: {
    eventHubAuthorizationRuleId: eventHubAuthorizationRuleId
    eventHubName: eventHubName
    logAnalyticsDestinationType: logAnalyticsDestinationType
    logs: logs
    marketplacePartnerId: marketplacePartnerId
    metrics: metrics
    serviceBusRuleId: serviceBusRuleId
    storageAccountId: storageAccountId
    workspaceId: workspaceId
  }
}



// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
output scope string = scope.id
