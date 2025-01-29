function Get-LogonLogoffEvents {
    param (
        [int]$DaysAgo
    )

    $loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$DaysAgo)
    $loginoutsTable = @()
    for ($i = 0 ; $i -lt $loginouts.Count ; $i++) {
	    $event = ""
	    if($loginouts[$i].InstanceID -eq 7001) {$event="Logon"}
	    if($loginouts[$i].InstanceID -eq 7002) {$event="Logoff"}
	    $user = $loginouts[$i].ReplacementStrings[1]
        $sid = New-Object System.Security.Principal.SecurityIdentifier($user)
        $objUser = $sid.Translate([System.Security.Principal.NTAccount])
        $user = $objUser.Value
	    $loginoutsTable += [pscustomobject]@{
		    Time = $loginouts[$i].TimeGenerated
		    Id = $loginouts[$i].InstanceID
		    Event = $event
		    User = $user }
    }
    
    return $loginoutsTable
}

function Get-StartupShutdownEvents {
    param (
        [int]$DaysAgo
    )

    $startupShutdown = Get-EventLog System -After (Get-Date).AddDays(-$DaysAgo) | 
    Where-Object { $_.EventID -in @(6005, 6006) }
    $startupShutdownTable = @()
    for ($i = 0 ; $i -lt $startupShutdown.Count ; $i++) {
	    $event = ""
	    if($startupShutdown[$i].EventID -eq 6005) {$event="Startup"}
	    if($startupShutdown[$i].EventID -eq 6006) {$event="Shutdown"}
	    $user = "System"
	    $startupShutdownTable += [pscustomobject]@{
		    Time = $startupShutdown[$i].TimeGenerated
		    Id = $startupShutdown[$i].EventID
		    Event = $event
		    User = $user }
    }
    
    return $startupShutdownTable
}