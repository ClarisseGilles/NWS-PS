param ($host)

if (!$host) { $host = Read-Host "Enter the host to add" }

# save current list of trusted hosts
$curValue = (get-item wsman:\localhost\Client\TrustedHosts).value
#append new trusted host
set-item wsman:\localhost\Client\TrustedHosts -value "$curValue, $host"