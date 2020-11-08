param ($dnsName, $ip)

if (!$dnsName) { $dnsName = Read-Host "Enter the DHCP-server DNS name" }
if (!$ip) { $ip = Read-Host "Enter the DHCP-server IP" }

# authorize the DHCP server
Add-DhcpServerInDC -DnsName $dnsName -IPAddress $ip