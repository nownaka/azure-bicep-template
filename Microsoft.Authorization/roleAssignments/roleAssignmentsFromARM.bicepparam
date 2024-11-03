using './roleAssignmentsFromARM.bicep'

param resourceId = ''
param roleName = ''
param roleDefinitionId = ''
param principalId = ''
param principalType = ''
param roledescription = '' // leave these for logging in the portal

