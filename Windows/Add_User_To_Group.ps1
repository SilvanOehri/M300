<#
.SYNOPSIS
    Weist Benutzer den entsprechenden globalen Gruppen nach Abteilung zu.
.NOTES
    Autor: Silvan Oehri
    Datum: 2025-05-29
#>

$baseOU = "OU=Users,OU=osWDo,DC=osWDo,DC=local"

# Benutzer globalen Gruppen hinzufügen
Import-Module ActiveDirectory

# → Abteilung: GF
$users = Get-ADUser -Filter * -SearchBase "OU=GF,OU=Users,OU=osWDo,DC=osWDo,DC=local"
foreach ($user in $users) {
    Add-ADGroupMember -Identity "GG_GF" -Members $user.SamAccountName -ErrorAction SilentlyContinue
    Write-Host "✔ Zugewiesen: $($user.SamAccountName) → GG_GF"
}

# → Abteilung: Sekretariat
$users = Get-ADUser -Filter * -SearchBase "OU=Sekretariat,OU=Users,OU=osWDo,DC=osWDo,DC=local"
foreach ($user in $users) {
    Add-ADGroupMember -Identity "GG_Sekretariat" -Members $user.SamAccountName -ErrorAction SilentlyContinue
    Write-Host "✔ Zugewiesen: $($user.SamAccountName) → GG_Sekretariat"
}

# → Abteilung: Technik
$users = Get-ADUser -Filter * -SearchBase "OU=Technik,OU=Users,OU=osWDo,DC=osWDo,DC=local"
foreach ($user in $users) {
    Add-ADGroupMember -Identity "GG_Technik" -Members $user.SamAccountName -ErrorAction SilentlyContinue
    Write-Host "✔ Zugewiesen: $($user.SamAccountName) → GG_Technik"
}

# → Abteilung: Entwicklung
$users = Get-ADUser -Filter * -SearchBase "OU=Entwicklung,OU=Users,OU=osWDo,DC=osWDo,DC=local"
foreach ($user in $users) {
    Add-ADGroupMember -Identity "GG_Entwicklung" -Members $user.SamAccountName -ErrorAction SilentlyContinue
    Write-Host "✔ Zugewiesen: $($user.SamAccountName) → GG_Entwicklung"
}

# → Abteilung: Schulung
$users = Get-ADUser -Filter * -SearchBase "OU=Schulung,OU=Users,OU=osWDo,DC=osWDo,DC=local"
foreach ($user in $users) {
    Add-ADGroupMember -Identity "GG_Schulung" -Members $user.SamAccountName -ErrorAction SilentlyContinue
    Write-Host "✔ Zugewiesen: $($user.SamAccountName) → GG_Schulung"
}

# → Abteilung: Kurse
$users = Get-ADUser -Filter * -SearchBase "OU=Kurse,OU=Users,OU=osWDo,DC=osWDo,DC=local"
foreach ($user in $users) {
    Add-ADGroupMember -Identity "GG_Kurse" -Members $user.SamAccountName -ErrorAction SilentlyContinue
    Write-Host "✔ Zugewiesen: $($user.SamAccountName) → GG_Kurse"
}

# → Abteilung: Produktion
$users = Get-ADUser -Filter * -SearchBase "OU=Produktion,OU=Users,OU=osWDo,DC=osWDo,DC=local"
foreach ($user in $users) {
    Add-ADGroupMember -Identity "GG_Produktion" -Members $user.SamAccountName -ErrorAction SilentlyContinue
    Write-Host "✔ Zugewiesen: $($user.SamAccountName) → GG_Produktion"
}
