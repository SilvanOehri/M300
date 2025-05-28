<#
.SYNOPSIS
    Creates an OU structure based on the Modul 300 case study for osWDo.local.

.DESCRIPTION
    This script sets up all required OUs to support user, group, computer, and server management 
    in a structured Active Directory domain.

.NOTES
    Author   : Silvan Oehri
    Version  : 1.0
    Date     : 2025-05-28
    Domain   : osWDo.local
#>

# ==== CONFIGURATION ====
$baseDN = "DC=osWDo,DC=local"
$rootOU = "OU=osWDo" # Root OU for the company

# ==== OU DEFINITIONS ====
$ous = @(
    "$rootOU",
    "OU=Users,$rootOU",
    "OU=GF,OU=Users,$rootOU",
    "OU=GL,OU=Users,$rootOU",
    "OU=Sekretariat,OU=Users,$rootOU",
    "OU=Technik,OU=Users,$rootOU",
    "OU=Entwicklung,OU=Users,$rootOU",
    "OU=Schulung,OU=Users,$rootOU",
    "OU=Kurse,OU=Users,$rootOU",
    "OU=Produktion,OU=Users,$rootOU",
    "OU=Groups,$rootOU",
    "OU=Computers,$rootOU",
    "OU=Servers,$rootOU"
)

# ==== CREATE OUs ====
foreach ($ou in $ous) {
    $dn = "$ou,$baseDN"
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$dn)" -ErrorAction SilentlyContinue)) {
        try {
            New-ADOrganizationalUnit -Name ($ou -split "=")[1] -Path ($ou -replace "^OU=[^,]+,", "") -ProtectedFromAccidentalDeletion $true
            Write-Host "Created OU: $dn"
        }
        catch {
            Write-Host "Failed to create OU: $dn" -ForegroundColor Red
        }
    }
    else {
        Write-Host "OU already exists: $dn" -ForegroundColor Yellow
    }
}
