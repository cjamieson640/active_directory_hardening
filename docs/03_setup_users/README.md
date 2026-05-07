# Setting up Users
The way I went about generating the users for my active directory was by using Claude. I gave claude my OU structure and asked it to generate a csv file of 40-50 users to replicate a small business. Here are a few examples of the users claude generated.
```csv
GivenName,Surname,Name,SamAccountName,UserPrincipalName,Department,Title,OU,Password,Groups
Marcus,Chen,Marcus Chen,mchen,mchen@jamieson.local,IT,IT Manager,"OU=Users,OU=IT,OU=Departments,OU=Corp,DC=jamieson,DC=local",TempPass123!,IT-Users;IT-Admins;Domain Admins
Priya,Patel,Priya Patel,ppatel,ppatel@jamieson.local,IT,Systems Administrator,"OU=Users,OU=IT,OU=Departments,OU=Corp,DC=jamieson,DC=local",TempPass123!,IT-Users;IT-Admins
Jordan,Reeves,Jordan Reeves,jreeves,jreeves@jamieson.local,IT,Help Desk Technician,"OU=Users,OU=IT,OU=Departments,OU=Corp,DC=jamieson,DC=local",TempPass123!,IT-Users;HelpDesk

```  
In order to populate the active directory I had to create a small powershell script, with some help from claude, to add the users into their departments. 
```powershell
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
```
This code loops through each user, takes the password and converts it into a secure string (encrypts the password), creates a new AD user, and enforces that the user changed their password when they first log on. The second foreach loop adds users into multiple assigned groups.