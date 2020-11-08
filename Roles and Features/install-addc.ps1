param ($target)

if (!$target) { $target = Read-Host "Enter the target computer name" }

# install ADDC feature
Install-WindowsFeature -ComputerName $target -Name "AD-Domain-Services" -IncludeManagementTools