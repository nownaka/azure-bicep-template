//
// Source: https://github.com/brwilkinson/AzureDeploymentFramework/blob/main/ADF/bicep/x.RBAC-ALL-RA-Resource.bicep
//

// param resourceName string = 'acu1brwaoap0sadiag/default/insights-logs-networksecuritygroupflowevent' //'acu1brwaoap0sadiag' // 'ACU1-PE-AOA-G1-kvGlobal'
// param resourceType string = 'Microsoft.Storage/storageAccounts/blobServices/containers'//'Microsoft.Storage/storageAccounts' //'Microsoft.KeyVault/vaults'

// param resourceName string = 'AWU1-PE-AOA-P0-vn' //'acu1brwaoap0sadiag' // 'ACU1-PE-AOA-G1-kvGlobal'
// param resourceType string = 'Microsoft.Network/virtualNetworks'//'Microsoft.Storage/storageAccounts' //'Microsoft.KeyVault/vaults'

@description('Resource Id for role assignment scope')
param resourceId string
@description('Role name for assignment')
param roleName string
@description('Role definition Id. Format: aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee')
param roleDefinitionId string
@description('Principal Id on Entra Id.')
param principalId string
@description('The principal type of the assigned principal Id.')
param principalType string = ''

#disable-next-line no-unused-params
param roledescription string = '' // leave these for logging in the portal

@description('The resource name')
var name = guid(principalId, roleDefinitionId, resourceGroup().id)

// // ----------------------------------------------
// // Implement own resourceId for any segment length
// var segments = split(resourceType,'/')
// var items = split(resourceName,'/')
// var last = length(items)
// var segment = [for (item, index) in range(1,last) : item == 1 ? '${segments[0]}/${segments[item]}/${items[index]}/' : item != last ? '${segments[item]}/${items[index]}/' : '${segments[item]}/${items[index]}' ]
// var resourceid =  join(string(segment)), '","', ''), '["', ''), '"]', '') // currently no join() method
// // ----------------------------------------------

@description('Role Assignments.')
#disable-next-line no-deployments-resources
resource ResourceRoleAssignment 'Microsoft.Resources/deployments@2024-07-01' = {
    name: take('dp-RRA-${roleName}-${last(split(resourceId,'/'))}',64)
    properties: {
        mode: 'Incremental'
        expressionEvaluationOptions: {
            scope: 'Outer'
        }
        template: json(loadTextContent('./roleAssignments.json'))
        parameters: {
            scope: {
                value: resourceId
            }
            name: {
                value: name
            }
            roleDefinitionId: {
                value: roleDefinitionId
            }
            principalId: {
                value: principalId
            }
            principalType: {
                value: principalType
            }
        }
    }
}

output resourceId string = resourceId
output roleAssignmentId string = ResourceRoleAssignment.properties.outputs.roleAssignmentId.value
