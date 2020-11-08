param ($target, $domain, $pass)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$domain) { $domain = Read-Host "Enter the domain name" }
if (!$pass) { $pass = Read-Host "Enter the safe mode administrator password name" }

# Command to promote to DC in existing domain
$cmdDc = { param ($domain, $credential, $pass) Install-ADDSDomainController -DomainName $domain -Credential $credential -InstallDns:$true -CreateDnsDelegation:$false -SafeModeAdministratorPassword (ConvertTo-SecureString $pass -AsPlainText -Force) -DatabasePath “C:\\Windows\\NTDS” -LogPath “C:\\Windows\\NTDS” -SysvolPath “C:\\Windows\\SYSVOL” -Force }

# Ask for credential with correct permissions on remote system
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$credential = Get-Credential -Message "Supply credential with admin permissions on $target" -UserName $user

if ($target -eq $env:computername) #avoid using remoting if target is the local computer
{
    # install ADDC to existing domain
    & $cmdDc -domain $domain -credential $credential -pass $pass
} 
else 
{
    # install ADDC to existing domain
    Invoke-Command -ComputerName $target -ScriptBlock $cmdDc -Credential $credential
}

