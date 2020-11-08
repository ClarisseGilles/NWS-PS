param ($target, $dns1, $dns2)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$dns1) { $dns1 = Read-Host "Enter the first DNS IP" }
if (!$dns2) { $dns2 = Read-Host "Enter the second DNS IP" }

# Command that gets and lists all network interfaces
$cmdIf = { Get-NetAdapter -Name "*" -IncludeHidden | Format-Table -Property ifIndex,Name,Status -AutoSize }
# Command to set IPv4 DNS servers
$cmdDns = { param ($dns1, $dns2, $if) Set-DnsClientServerAddress -ServerAddresses ($dns1,$dns2) -InterfaceIndex $if }

if ($target -eq $env:computername) #avoid using remoting if target is the local computer
{
    # List and ask for correct network interface
    & $cmdIf
    $if = Read-Host "Enter the interface index from the list"
    # Change target DNS servers
    & $cmdDns -dns1 $dns1 -dns2 $dns2 -if $if
} 
else 
{
    # Ask for credential with correct permissions on remote system
    $user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $credential = Get-Credential -Message "Supply credential with admin permissions on $target" -UserName $user
    # List and ask for correct network interface
    Invoke-Command -ComputerName $target -ScriptBlock $cmdIf -Credential $credential
    $if = Read-Host "Enter the interface index from the list"
    # Change target DNS servers
    Invoke-Command -ComputerName $target -ScriptBlock $cmdDns -ArgumentList $dns1, $dns1, $if -Credential $credential
}