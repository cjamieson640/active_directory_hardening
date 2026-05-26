Import-Csv .\users.csv | ForEach-Object {
    $securePass = ConvertTo-SecureString $_.Password -AsPlainText -Force
    New-ADUser -GivenName $_.GivenName -Surname $_.Surname -Name $_.Name `
        -SamAccountName $_.SamAccountName -UserPrincipalName $_.UserPrincipalName `
        -Department $_.Department -Title $_.Title -Path $_.OU `
        -AccountPassword $securePass -Enabled $true -ChangePasswordAtLogon $true
    
    foreach ($group in ($_.Groups -split ';')) {
        Add-ADGroupMember -Identity $group.Trim() -Members $_.SamAccountName
    }
}