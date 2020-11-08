param ($target, $newName)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$newName) { $newName = Read-Host "Enter the new computer name" }

# Ask for credential with correct permissions on remote system
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$credential = Get-Credential -Message "Supply credential with admin permissions on $target" -UserName $user

Rename-Computer -ComputerName $target -NewName $newName -DomainCredential $credential -Force