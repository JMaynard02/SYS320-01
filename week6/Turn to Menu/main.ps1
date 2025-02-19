. (Join-Path $PSScriptRoot Parsing-Apache-Logs.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot ProcessManagement1.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display Last 10 Apache Logs`n"
$Prompt += "2 - Display Last 10 Failed Logins for All Users`n"
$Prompt += "3 - Display At-Risk Users`n"
$Prompt += "4 - Start Chrome and go to champlain.edu`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    # Last 10 Apache Logs
    elseif($choice -eq 1){

        $tableRecords = ApacheLogs1
        $tableRecords | Select -last 10 | Format-Table -AutoSize -Wrap

    }

    # Last 10 failed logins
    elseif($choice -eq 2){

        $userLogins = getFailedLogins 90
        Write-Host ($userLogins | Select -last 10 | Format-Table | Out-String)

    }

    # Display at-risk users
    elseif($choice -eq 3){ 

        $userLogins = getFailedLogins 90
        Write-Host "Displaying users with 10 or more failed login attempts" | Out-String

        Write-Host ($userLogins | Group-Object -Property User | Where-Object Count -ge 10 |`
        Select-Object Name, Count | Format-Table | Out-String)

    }

    # Start chrome and go to champlain.edu if not running already
    elseif($choice -eq 4){
        launchSite
    }

    else {
        Write-Host "Please enter a valid number corresponding with one of the choices (from 1-5)"
    }
}