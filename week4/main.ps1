. (Join-Path $PSScriptRoot Apache-Logs.ps1)

clear

$ipsTable = GetIPAddress -page 'index.html' -code ' 200 ' -browser 'Chrome'
$ipsTable
