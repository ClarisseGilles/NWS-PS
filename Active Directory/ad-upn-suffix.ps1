param ($upn)

if (!$upn) { $upn = Read-Host "Enter the new UPN Suffix" }

# add the UPN suffix
Get-ADForest | Set-ADForest -UPNSuffixes @{add=$upn}