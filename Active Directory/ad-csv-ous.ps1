param ($csv)

if (!$csv) { $csv = Read-Host "Enter the path to the CSV file" }

$ous = Import-Csv $csv -Delimiter ";"

foreach ($ou in $ous)
{
    $dName = "OU=$($ou.Name),$($ou.Path)"
    If(Get-ADOrganizationalUnit -Filter { distinguishedName -eq  $dName })
    {
        Write-Warning "OU $($ou.Name) already exists in $($ou.Path)"
    }
    else 
    {
        ## Create the OU with Accidental Deletion enabled
        New-ADOrganizationalUnit `
            -Path $ou.Path `            -DisplayName $ou."Display Name" `            -Name $ou.Name `            -Description $ou.Description

        Write-Host -ForegroundColor Cyan "OU $($ou.Name) was created in $($ou.Path)"
    }
}