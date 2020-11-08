param ($target, $name, $start, $end, $mask)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$name) { $name = Read-Host "Enter the scope name" }
if (!$start) {$start = Read-Host "Enter the range start" }
if (!$end) {$end = Read-Host "Enter the range end" }
if (!$mask) {$mask = Read-Host "Enter the subnetmask" }

# create the scope
Add-DHCPServerv4Scope -ComputerName $target -Name $name -StartRange $start -EndRange $end -SubnetMask $mask -State Active