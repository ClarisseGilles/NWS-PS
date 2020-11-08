param ($target, $dns1, $dns2, $domain)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$dns1) { $dns1 = Read-Host "Enter the first DNS IP" }
if (!$dns2) { $dns2 = Read-Host "Enter the second DNS IP" }
if (!$domain) { $domain = Read-Host "Enter the DNS domain" }

# Set the DHCP server DNS options
Set-DHCPServerv4OptionValue -ComputerName $target -DnsServer "$dns1 , $dns2" -DnsDomain $domain -Force