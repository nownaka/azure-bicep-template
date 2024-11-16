using './schedules.bicep'

param automationAccountName = ''
param scheduleName = ''
param advancedSchedule = null

param scheduleDescription = null

param expiryTime = null

param frequency = 'Day'
param interval = 0
param startTime = ''
param timeZone = 'Asia/Tokyo'

