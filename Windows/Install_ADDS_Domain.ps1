<#
.SYNOPSIS
    Installs the AD DS role and sets up a new domain with DNS.

.DESCRIPTION
    This script installs the Active Directory Domain Services role,
    creates a new forest and domain, installs DNS, sets the DSRM password,
    and restarts the server.

.NOTES
    Author   : Silvan Oehri
    Date     : 2025-04-12
    Version  : 1.0
#>

# ==== CONFIGURATION ====
$domainName = "osWDo.local"
$netbiosName = "OSWDO"
$logFile = "C:\ADDS_Setup.log"

# ==== FUNCTIONS ====
function Write-Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "[$timestamp] $message"
    Write-Host $message
}

function Handle-Error {
    param ([string]$context, [System.Exception]$error)
    Write-Log "ERROR during $context: $($error.Exception.Message)"
    exit 1
}

# ==== START ====
Write-Log "=== Starting AD DS Setup ==="

# Step 1: Install AD DS role
Write-Log "Installing AD DS role..."
try {
    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -ErrorAction Stop
    Write-Log "AD DS role installed successfully."
}
catch {
    Handle-Error "role installation" $_
}

# Step 2: Prompt for DSRM password
try {
    $dsrmPassword = Read-Host -AsSecureString "Enter DSRM password"
}
catch {
    Handle-Error "DSRM password input" $_
}

# Step 3: Promote server to domain controller
Write-Log "Creating new domain '$domainName'..."
try {
    Install-ADDSForest `
        -DomainName $domainName `
        -DomainNetbiosName $netbiosName `
        -SafeModeAdministratorPassword $dsrmPassword `
        -InstallDNS `
        -Force `
        -ErrorAction Stop

    Write-Log "Domain setup successful. Rebooting server..."
}
catch {
    Handle-Error "domain setup" $_
}

# ==== RESTART SERVER ====
Restart-Computer -Force
