function GetIPAddress {
    param (
        [string]$page,
        [string]$code,
        [string]$browser
    )

    $codesort = Get-Content C:\xampp\apache\logs\access.log | Select-String $code
    $pagesort = $codesort | Select-String $page
    $browsersort = $pagesort | Select-String $browser

    $regex = [regex] "(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"
    $ipsUnorganized = $regex.Matches($browsersort)
    $ips = @()
    for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
        $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value }
    }
    $ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
    $ipsTable = $ipsoftens | Group-Object -Property IP

    return $ipsTable | Select-Object Count, Name
}
