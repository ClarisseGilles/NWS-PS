param ($target)

if (!$target) { $target = Read-Host "Enter the target computer name" }

# install DHCP feature
Install-WindowsFeature -ComputerName $target -Name "DHCP" –IncludeManagementTools