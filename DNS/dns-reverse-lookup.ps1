param ($nId)

if (!$nId) { $nId = Read-Host "Enter the network ID" }

# Add reverse lookup for given network ID
Add-DnsServerPrimaryZone -NetworkID $nId -ReplicationScope Domain