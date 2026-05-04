# 01_setup_dc

## Enable PSRemoting
With the VMs set up sign into the MGMT01 machine and run these commands:  

Start Windows Remote Management  
```shell
Start-Service WinRM
```
Set DC1 to trusted hosts  
```shell
set-item wsman:\localhost\Client\TrustedHosts -value <DC1 IP address>
```
Start a new PowerShell Session with DC1. Get-Credentials will be your login for DC1  
```shell
New-PSSession -ComputerName <Domain Controller IP address> -Credential (Get-Credential)
```
Enter the PSSession using the assigned session ID  
```shell
Enter-PSSession <session_id>
```

## Setting up an Active Directory
Switch to the DC1 VM and use SConfig to change the following:  
    - Hostname  
    - IP address to static (network settings)  
    - DNS server to DC1 IP Address  

Enter PSSession using new IP Address:  
``` shell
Enter-PSSession <New IP for DC1> -Credential (Get-Credential)
```
Install the Active Directory Windows Feature:  
```shell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```
Configure Active Directory Windows Server 2022. Set domain name to FQDN for the root of the doimain in the Active Directory forest ex. xyz.local  
```shell
import-Module ADDSDeployment
install-ADDSForest
```
Changing DNS Server on WS01 using CLI:  
Get the current IP address of WS01:  
```shell
Get-NetIPAddress
```
Get the InterfaceIndex from the current DNS server:  
```shell
Get-NetIPAddress -IPAddress <WS01 IP Address>
```
Use the InterfaceIndex to set the DNS Client Server Address to the DC1 IP Address  
```shell
Set-DNSClientServerAddress -InterfaceIndex <InterfaceIndex> -ServerAddresses <DC1 IP Address>
```
Take a snapshot of the current state of the workstation  