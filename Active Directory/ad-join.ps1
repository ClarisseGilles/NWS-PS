param ($target, $domain)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$domain) { $domain = Read-Host "Enter the domain name" }

# Ask for credential with correct permissions on remote system
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$credential = Get-Credential -Message "Supply credential with admin permissions on $target" -UserName $user

# add the target computer to the domain
add-computer -computername $target -domainname $domain –credential $credential -restart –force