. (Join-Path $PSScriptRoot courses.ps1)

clear

$courseTable = gatherClasses
$FullTable = daysTranslator($courseTable)

# For problem i
#$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
#            Where {$_."Instructor" -ilike "Furkan Paligu" }

# For problem ii
#$FullTable | Where { ($_.Location -ilike "JOYC 310") -and ($_.days -ilike "Wednesday") } | `
#            Sort-Object "Time Start" | Format-Table "Time Start", "Time End", "Class Code"

# For problem iii
$ITSInstructors = $FullTable | Where { ($_."Class Code" -ilike "SYS*") -or `
                                        ($_."Class Code" -ilike "NET*") -or `
                                        ($_."Class Code" -ilike "SEC*") -or `
                                        ($_."Class Code" -ilike "FOR*") -or `
                                        ($_."Class Code" -ilike "CSI*") -or `
                                        ($_."Class Code" -ilike "DAT*") } `
                            | Sort-Object "Instructor" `
                            | Select-Object "Instructor" -unique
#$ITSInstructors     
                            
# For problem iv
$FullTable | Where {$_.Instructor -in $ITSInstructors.Instructor } `
            | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending