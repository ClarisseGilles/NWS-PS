param ($target, $scope, $gateway)

if (!$target) { $target = Read-Host "Enter the target computer name" }
if (!$scope) { $scope = Read-Host "Enter the scope ID" }
if (!$gateway) { $gateway = Read-Host "Enter the gateway IP" }

# add the gateway to the scope
Set-DHCPServerv4OptionValue -ComputerName $target -ScopeId $scope -Router $gateway