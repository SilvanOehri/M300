<#
.SYNOPSIS
    Configures Windows DNS server with forward and reverse zones.
    Adds a forwarder and sets up zone replication with a secondary Linux DNS.

.NOTES
    Network: 192.168.12.0/24
    Linux Secondary DNS IP: 192.168.12.11
    Author: Silvan Oehri
    Version: 1.0
    Date: 2025-04-03
#>

$domainZone = "oeWDo.local"
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
Add-DnsServerPrimaryZone `
    -Name $domainZone `
    -ZoneFile "$domainZone.dns" `
    -DynamicUpdate Secure `
    -ReplicationScope "Domain"

# 3. Create Reverse Lookup Zone
Write-Log "Creating reverse lookup zone '$reverseZone'..."
Add-DnsServerPrimaryZone `
    -NetworkId "192.168.12.0/24" `
    -ZoneFile "$reverseZone.dns" `
    -DynamicUpdate Secure `
    -ReplicationScope "Domain"

# 4. Configure Linux DNS as secondary zone server
Write-Log "Allowing zone transfers to $secondaryDnsIP..."
Set-DnsServerPrimaryZone `
    -Name $domainZone `
    -Notify Secondary `
    -SecondaryServers $secondaryDnsIP

Set-DnsServerPrimaryZone `
    -Name $reverseZone `
    -Notify Secondary `
    -SecondaryServers $secondaryDnsIP

# 5. Add DNS Forwarder to Linux/BIND
Write-Log "Adding forwarder to $dnsForwarder..."
Add-DnsServerForwarder `
    -IPAddress $dnsForwarder `
    -PassThru

Write-Log "DNS configuration complete."
