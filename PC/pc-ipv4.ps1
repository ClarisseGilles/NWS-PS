param ($target, $ip, $prefix, $gateway)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$ip) { $ip = Read-Host "Enter the new IP" }
if (!$prefix) { $prefix = Read-Host "Enter the prefix length" }
if (!$gateway) { $gateway = Read-Host "Enter the default gateway" }

# Command that gets and lists all network interfaces
$cmdIf = { Get-NetAdapter -Name "*" -IncludeHidden | Format-Table -Property ifIndex,Name,Status -AutoSize }
# Command to set the IPv4 settings, removing the old ones first
$cmdIp = { param ($ip, $prefix, $gateway, $if)           Remove-NetIPAddress -InterfaceIndex $if -IncludeAllCompartments -Confirm:$false           If ($oldGateway = (Get-NetIPConfiguration -InterfaceIndex $if).IPv4DefaultGateway.NextHop) { 
           Remove-NetRoute -InterfaceIndex $if -NextHop $oldGateway -Confirm:$false }
           New-NetIPAddress -InterfaceIndex $if -IPAddress $ip -PrefixLength $prefix -DefaultGateway $gateway }

if ($target -eq $env:computername) # Avoid using remoting if target is the local computer
{
    # List and ask for correct network interface
    & $cmdIf
    $if = Read-Host "Enter the interface index from the list"
    # Change IP
    & $cmdIp -ip $ip -prefix $prefix -gateway $gateway -if $if
} 
else 
{
    # Ask for credential with correct permissions on remote system
    $user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $credential = Get-Credential -Message "Supply credential with admin permissions on $target" -UserName $user
    # List and ask for correct network interface
    Invoke-Command -ComputerName $target -ScriptBlock $cmdIf -Credential $credential
    $if = Read-Host "Enter the interface index from the list"
    # Change IP
    Invoke-Command -ComputerName $target -ScriptBlock $cmdIp -ArgumentList $ip, $prefix, $gateway, $if -Credential $credential
}