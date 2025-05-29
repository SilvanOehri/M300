<#
.SYNOPSIS
    Erstellt einen DHCP-IPv4-Bereich mit dynamischem IP-Adressbereich.
.NOTES
    Autor: Silvan Oehri
    Datum: 2025-05-29
#>

$scopeName     = "osWDo-Scope"
$scopeStart    = "192.168.12.16"
$scopeEnd      = "192.168.12.250"
$subnetMask    = "255.255.255.0"
$scopeComment  = "DHCP range for osWDo Network"

Install-WindowsFeature DHCP -IncludeManagementTools

if (-not (Get-DhcpServerv4Scope -ScopeId "192.168.12.0" -ErrorAction SilentlyContinue)) {
    Add-DhcpServerv4Scope `
        -Name $scopeName `
        -StartRange $scopeStart `
        -EndRange $scopeEnd `
        -SubnetMask $subnetMask `
        -State Active `
        -Description $scopeComment
    Write-Host "✔ DHCP-Scope erstellt: $scopeName ($scopeStart - $scopeEnd)"
} else {
    Write-Host "⚠️ DHCP-Scope für 192.168.12.0 existiert bereits." -ForegroundColor Yellow
}