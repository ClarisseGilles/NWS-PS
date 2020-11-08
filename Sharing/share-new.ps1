param ($target, $share, $dir)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$share) { $share = Read-Host "Enter the share name" }
if (!$dir) { $dir = Read-Host "Enter the share directory" }

# command to create the directory
$cmdDir = { param ($dir) New-Item $dir –type directory -Force }
# command to share the directory
$cmdShare = { param ($dir, $name) New-SmbShare -Name $name -Path $dir | Grant-SmbShareAccess -AccountName Everyone -AccessRight Full }


if ($target -eq $env:computername) #avoid using remoting if target is the local computer
{
    # create directory
    & $cmdDir -dir $dir
    # share directory
    & $cmdShare -dir $dir -name $share
} 
else 
{
    # Ask for credential with correct permissions on remote system
    $user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $credential = Get-Credential -Message "Supply credential with admin permissions on $target" -UserName $user
    # create directory
    Invoke-Command -ComputerName $target -ScriptBlock $cmdDir -ArgumentList $dir -Credential $credential
    # share directory
    Invoke-Command -ComputerName $target -ScriptBlock $cmdShare -ArgumentList $dir, $share -Credential $credential
}