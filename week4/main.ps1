. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot Parsing-Apache-Logs.ps1)

clear

#Windows Apache Logs Assignment
$ipsTable = GetIPAddress -page 'index.html' -code ' 200 ' -browser 'Chrome'
$ipsTable

#Parsing Apache Logs Assignment
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap
