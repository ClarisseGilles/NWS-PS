param ($csv)

if (!$csv) { $csv = Read-Host "Enter the path to the CSV file" }

$members = Import-Csv $csv -Delimiter ";"

foreach ($member in $members) {
    # Check to see if the group does not exist in AD
    $mMember = $member.Member
    $mIdentity = $member.Identity
    if (-not (Get-ADGroup -F { Name -eq $mIdentity }))
    {
        
        # If group does not exist, give a warning
        Write-Warning "A group with name $($member.Identity) does not exist in Active Directory."
    }
    else 
    {
        if ((-not (Get-ADUser -F { SamAccountName -eq $mMember })) -and (-not (Get-ADGroup -F { Name -eq $mMember })))
        {
        
            # If user does exist, give a warning
            Write-Warning "A group or user with name $($member.Member) does not exist in Active Directory."
        }
        else
        {
            Add-ADGroupMember -Identity $member.Identity -Members $member.Member

            Write-Host -ForegroundColor Cyan "The member $($member.Member) was added to group $($member.Identity)"
        }
    }
}