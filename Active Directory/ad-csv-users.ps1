param ($csv)

if (!$csv) { $csv = Read-Host "Enter the path to the CSV file" }

$users = Import-Csv $csv -Delimiter ";"

foreach ($user in $users) {
    # Check to see if the user already exists in AD
    $uName = $user.SamAccountName
    if (Get-ADUser -F { SamAccountName -eq $uName }) 
    {
        
        # If user does exist, give a warning
        Write-Warning "A user account with username $($user.SamAccountName) already exists in Active Directory."
    }
    else 
    {

        # User does not exist then proceed to create the new user account
        # Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADUser `
            -Name $user.Name `
            -SamAccountName $user.SamAccountName `
            -GivenName $user.GivenName `
            -Surname $user.Surname `
            -DisplayName $user.DisplayName `
            -UserPrincipalName $user.UPN `
            -AccountPassword (ConvertTo-secureString $user.AccountPassword -AsPlainText -Force) -ChangePasswordAtLogon $False `
            -HomeDrive $user.HomeDrive `
            -HomeDirectory $user.HomeDirectory `
            -ScriptPath $user.ScriptPath `
            -Path $user.Path `
            -Enabled $True `


        # If user is created, show message.
        Write-Host -ForegroundColor Cyan "The user account $($user.SamAccountName) was created." 
    }
}