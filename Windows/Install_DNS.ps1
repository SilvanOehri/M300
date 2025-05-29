<#
.SYNOPSIS
    Configures Windows DNS server with forward and reverse zones.
    Adds a forwarder and sets up zone replication with a secondary Linux DNS.

.NOTES
    Network: 192.168.12.0/24
    Linux Secondary DNS IP: 192.168.12.11
    Author: Silvan Oehri
    Version: 1.1
    Date: 2025-05-29
#>

$domainZone = "osWDo.local"
$reverseZone = "12.168.192.in-addr.arpa"
$secondaryDnsIP = "192.168.12.11"
$dnsForwarder = "192.168.12.11"

# Logging
function Write-Log {
    param([string]$msg)
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$time] $msg"
}

# 1. Install DNS Role
Write-Log "Installing DNS Server role..."
Install-WindowsFeature DNS -IncludeManagementTools

# 2. Create Forward Lookup Zone
Write-Log "Creating forward lookup zone '$domainZone'..."
Add-DnsServerPrimaryZone 
    -Name $domainZone 
    -DynamicUpdate Secure 
    -ReplicationScope "Domain"

# 3. Create Reverse Lookup Zone
Write-Log "Creating reverse lookup zone '$reverseZone'..."
Add-DnsServerPrimaryZone 
    -Name $reverseZone 
    -DynamicUpdate Secure 
    -ReplicationScope "Domain"

# 4. Configure Linux DNS as secondary zone server
if (Get-DnsServerZone -Name $domainZone -ErrorAction SilentlyContinue) {
    Write-Log "Allowing zone transfers for '$domainZone' to $secondaryDnsIP..."
    Set-DnsServerPrimaryZone 
        -Name $domainZone 
        -Notify NotifyServers 
        -NotifyServers $secondaryDnsIP
} else {
    Write-Log "Forward zone '$domainZone' not found. Skipping zone transfer setup."
}

if (Get-DnsServerZone -Name $reverseZone -ErrorAction SilentlyContinue) {
    Write-Log "Allowing zone transfers for '$reverseZone' to $secondaryDnsIP..."
    Set-DnsServerPrimaryZone 
        -Name $reverseZone 
        -Notify NotifyServers 
        -NotifyServers $secondaryDnsIP
} else {
    Write-Log "Reverse zone '$reverseZone' not found. Skipping zone transfer setup."
}

# 5. Add DNS Forwarder to Linux/BIND
Write-Log "Adding forwarder to $dnsForwarder..."
$existingForwarders = (Get-DnsServerForwarder).IPAddress
if ($existingForwarders -contains $dnsForwarder) {
    Write-Log "Forwarder $dnsForwarder is already configured."
} else {
    Add-DnsServerForwarder -IPAddress $dnsForwarder -PassThru
}

Write-Log "DNS configuration complete."
