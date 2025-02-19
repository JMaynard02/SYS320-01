<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword($password) {
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringtoBSTR($password)
    $plainpassword = [System.Runtime.InteropServices.Marshal]::PTRtoStringAuto($bstr)

    if ($plainpassword -notmatch "[^a-zA-Z0-9\s]" -or $plainpassword -notmatch "\d" -or `
        $plainpassword -notmatch "[a-zA-Z]") {
        return $false
    }
    if ($plainpassword.Length -lt 6) {
        return $false
    }

    return $true
}