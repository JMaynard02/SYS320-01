. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List At-Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        if (checkUser($name)) {
            Write-Host "User already exists" | Out-String
        }
        else {
            $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
            if (checkPassword($password)) {

                createAUser $name $password

                Write-Host "User: $name is created." | Out-String
            }
            else {
                Write-Host "Password must be at least 6 characters and contain at least 1 special character, 1 number, and 1 letter" | Out-String   
            }
        }
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        if (checkUser ($name)) {
            removeAUser $name

            Write-Host "User: $name Removed." | Out-String
        }
        else {
            Write-Host "User not found" | Out-String
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if (checkUser ($name)) {
            enableAUser $name

            Write-Host "User: $name Enabled." | Out-String
        }
        else {
            Write-Host "User not found" | Out-String
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if (checkUser ($name)) {
            disableAUser $name

            Write-Host "User: $name Disabled." | Out-String
        }

        else {
            Write-Host "User not found" | Out-String
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        if (checkUser ($name)) {
            $days = Read-Host -Prompt "Please enter number of days of logs to look at"
            $userLogins = getLogInAndOffs $days
            

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else {
            Write-Host "User not found" | Out-String
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if (checkUser ($name)) {
            $days = Read-Host -Prompt "Please enter number of days of logs to look at"
            $userLogins = getFailedLogins $days

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else {
            Write-Host "User not found" | Out-String
        }
    }
    
    # At-Risk Users
    elseif($choice -eq 9){
        $days = Read-Host -Prompt "Please enter number of days of logs to look at"
        $userLogins = getFailedLogins $days
        Write-Host "Displaying users with 10 or more failed login attempts" | Out-String

        Write-Host ($userLogins | Group-Object -Property User | Where-Object Count -ge 10 |`
        Select-Object Name, Count | Format-Table | Out-String)
    }

    # Validation
    else {
        Write-Host "Please enter a valid number corresponding with one of the choices (from 1-10)"
    }
}
