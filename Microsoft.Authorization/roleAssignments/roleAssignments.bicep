//
// Reference: https://learn.microsoft.com/ja-jp/azure/templates/microsoft.authorization/roleassignments?pivots=deployment-language-bicep
//

// --------------------------------------------------------------------------------
// Params
// --------------------------------------------------------------------------------
@description('Specifies the role definition ID used in the role assignment.')
param roleDefinitionId string
@description('Specifies the principal ID assigned to the role.')
param principalId string


// --------------------------------------------------------------------------------
// Variables
// --------------------------------------------------------------------------------
@description('The resource name')
var roleAssignmentName= guid(principalId, roleDefinitionId, resourceGroup().id)


// --------------------------------------------------------------------------------
// Resources
// --------------------------------------------------------------------------------
@description('Role Assignments.')
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: roleAssignmentName
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalId: principalId
  }
}


// --------------------------------------------------------------------------------
// Outputs
// --------------------------------------------------------------------------------
@description('Resource name of Role Assignments.')
output name string = roleAssignment.name
@description('Resource Group name of Role Assignments.')
output resourceGroupName string = resourceGroup().name
@description('Resource Id of Role Assignments.')
output resourceId string = roleAssignment.id
