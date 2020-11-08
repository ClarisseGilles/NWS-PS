param ($domain, $netbios, $pass)

if (!$domain) { $domain = Read-Host "Enter the domain name" }
if (!$netbios) { $netbios = Read-Host "Enter the netbios name" }
if (!$pass) { $pass = Read-Host "Enter the safemode administrator password" }

# install ADDC to new domain
Install-ADDSForest -DomainName $domain -ForestMode “WinThreshold” -DomainMode “WinThreshold” -InstallDns:$true -CreateDnsDelegation:$false -SafeModeAdministratorPassword (ConvertTo-SecureString $pass -AsPlainText -Force) -DomainNetbiosName $netbios -DatabasePath “C:\\Windows\\NTDS” -LogPath “C:\\Windows\\NTDS” -SysvolPath “C:\\Windows\\SYSVOL” -Force