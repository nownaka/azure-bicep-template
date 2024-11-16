using './automationAccounts.bicep'

param automationAccountName = ''
param automationAccountLocation = ''
param tags = {}
param identityTyoe = 'None'

param identity = {
  type: identityTyoe
}
param disableLocalAuth = false
param publicNetworkAccess = true
param encryption = null

param skuName = 'Free'

