Import-Csv "ou.csv" | Sort-Object { ($_.Path -split ',').Count } | ForEach-Object {
    $dn = "OU=$($_.Name),$($_.Path)"
    if (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$dn'" -ErrorAction SilentlyContinue) {
        Write-Host "Skipped (exists): $dn" -ForegroundColor Yellow
    } else {
        try {
            New-ADOrganizationalUnit -Name $_.Name -Path $_.Path -ErrorAction Stop
            Write-Host "Created: $dn" -ForegroundColor Green
        } catch {
            Write-Host "Failed: $dn - $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}