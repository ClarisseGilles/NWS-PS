param ($target, $scope, $start, $end)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$start) { $start = Read-Host "Enter the range start" }
if (!$end) { $end = Read-Host "Enter the range end" }
if (!$scope) { $scope = Read-Host "Enter the scope ID" }

# create exclusion in the scope
Add-Dhcpserverv4ExclusionRange -ComputerName $target -ScopeId $scope -StartRange $start -EndRange $end