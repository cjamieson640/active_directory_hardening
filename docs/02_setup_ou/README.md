# Setting up Organizational Units
Creating Organizatonal Units through CLI was a completely unknown subject to me. After doing some research I found out OUs are commonly create in csv files, then a powershell script is used to add them to the domain. I asked Claude what the typical format was for an OU csv file and got this response.
```csv
Name,Path
Sales,"DC=contoso,DC=com"
Marketing,"DC=contoso,DC=com"
IT,"DC=contoso,DC=com"
Helpdesk,"OU=IT,DC=contoso,DC=com"
Servers,"OU=IT,DC=contoso,DC=com"
```
Using this template I decided to start off small to gain my bearings and just created a small IT OU:
```csv
Name,Path
Corp,"DC=jamieson,DC=local"
IT,"OU=Corp,DC=jamieson,DC=local"
Users,"OU=IT,OU=Corp,DC=jamieson,DC=local"
```

I then created a small powershell script with claude to add the OU to my Active Directory. This imports the csv file, adds each object to the AD as an OU based off the path we decided in the ou.csv file. It then writes it to the command line so we can verify each OU was added properly.
```powershell
Import-Csv "ou.csv" | ForEach-Object {
    New-ADOrganizationalUnit -Name $_.Name -Path $_.Path
    Write-Host "Created OU: $($_.Name) under $($_.Path)"
}
```