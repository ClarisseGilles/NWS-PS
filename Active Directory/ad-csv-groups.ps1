param ($csv)

if (!$csv) { $csv = Read-Host "Enter the path to the CSV file" }

$groups = Import-Csv $csv -Delimiter ";"

foreach ($group in $groups) {
    # Check to see if the user already exists in AD
    $gName = $group.Name
    if (Get-ADGroup -F { Name -eq $gName }) 
    {
        
        # If user does exist, give a warning
        Write-Warning "A group with name $($group.Name) already exists in Active Directory."
    }
    else 
    {

        # User does not exist then proceed to create the new user account
        # Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADGroup `
            -Path $group.Path `
            -Name $group.Name `
            -DisplayName $group.DisplayName `
            -Description $group.Description `
            -GroupCategory $group.GroupCategory `
            -GroupScope $group.GroupScope


        # If user is created, show message.
        Write-Host -ForegroundColor Cyan "The group $($group.Name) was created." 
    }
}