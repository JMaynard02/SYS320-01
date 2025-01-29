. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

# Get Login and Logoffs from last 15 days
$loginoutsTable = Get-LogonLogoffEvents -DaysAgo 15
$loginoutsTable

#Get Shutdowns and Startups from last 25 days
$startupShutdownTable = Get-StartupShutdownEvents -DaysAgo 25
$startupShutdownTable