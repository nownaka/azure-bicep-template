using './runbooks.bicep'

param automationAccountName = ''
param runbookName = ''
param runbookLocation = ''
param tags = {}
param runbookDescription = null

param runbookType = 'Graph'
param logVerbose = false
param logProgress = false
param logActivityTrace = 0
param publishContentLink = null


