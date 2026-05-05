Import-Csv "ou.csv" | ForEach-Object {
    New-ADOrganizationalUnit -Name $_.Name -Path $_.Path
    Write-Host "Created OU: $($_.Name) under $($_.Path)"
}