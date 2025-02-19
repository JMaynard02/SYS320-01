#Edited to be turned into a function
function launchSite() {
    $chrome = "chrome"
    $runningChrome = Get-Process -Name $chrome -ErrorAction 'SilentlyContinue' #added erroraction
    if ($runningChrome) {
        Stop-Process -Name $chrome -Force
        Write-Output "Chrome has been stopped."
    }
    else {
        Start-Process "chrome.exe" -ArgumentList "https://www.champlain.edu"
        Write-Output "Chrome has been started, directed to champlain.edu"
    } 
}