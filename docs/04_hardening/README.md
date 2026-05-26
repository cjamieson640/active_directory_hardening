# Hardening the Active Directory

## Password and Account Lockout Policy
1. Open Group Policy Management Console on you domain controller
- Search your computer for Group Policy Management
2. Create a Password Policy GPO
- Right click the domain name, then select "Create a GPO in this domain, and Link it here..."
- Name it Domain Password Policy
3. Set link order
- Click you domain name in the left panel
- In the hoizontal panel select "Linked Group Policy Objects"
- The password policy GPO should be at the top of the list. if its not, click it, and use the arrow keys to move it to the top spot.
4. Edit the GPO
- Right click the Password Policy GPO, click edit
- Select Computer Configuration, policies, windows settings, security settings, account policies

5. Conifgure Password Policy
- Enforce password history: 24 passwords
- Maximum password age: 60 days
- Minimum password age: 1 day
- Minimum password length: 14 characters
- Password must meet complexity: Enabled
- Storing passwords using reversible encryption: Disabled
- If a setting wasn't listed leave it Not Defined

6. Configure Account Lockout Policy
- Account lockout duration: 15 minutes
- Account lockout threshold: 5 invalid attempts
- Reset account lockout counter after 15 minutes

7. Save and Verify
- In PowerShell send the command: gpupdate /force
- Verify the policy with: Get-ADDefaultDomainPasswordPolicy

## Creating a GPO for Standard Users
1. Creating the GPO
- Go to the Group Policy Management Console
- Right click Group Policy Objects and select new
- Name it: User-Restrictions-StandardUsers
2. Restricting Control Panel
- Right click User-Restrictions-StandardUsers, then click edit
- Go to User Configuration, Policies, Administrative Templates, Control Panel
- Prohibit access to Control Panel and PC settings: Enabled
3. Restricting Command Prompt
- Go to System under User Configuration, Policies, Administrative Templates, System
- Prevent access to the command prompt: Enabled
4. Disable the Computer Configuration half
- Since this GPO only contains User Configuration settings, you can disable the Computer Configuration side so AD doesn't waste time evaluating empty computer settings at every logon.
- In GPMC, click on User-Restrictions-StandardUsers under Group Policy Objects
- Details tab, GPO Status dropdown, Computer configuration settings disabled
4. Link Finanace, HR, and Sales
- Right click Finance OU, Link an existing GPO, select User-Restrictions-StandardUsers
- Repeat for HR and Sales 

## Prevent Software Installation
1. Create the GPO
- Right click Group Policy Objects, New
- Name: Computer-Restrictions-StandardWorkstations
2. Edit the GPO
- Right click the new GPO, New
- Go to Computer Configuration, Policies, Administrative Templates, Windows Components, Windows Installer
- Turn off Windows installer (in the drop down choose For non-managed apps only)

## Removable media block
1. 
- Go to Computer Configuration, Policies, Administrative Templates, System, Removable Storage Access
- Enable, All Remoable Storage Classes: Deny all access

## Disable the unused User Configuration half
1. In Group Policy Management Console, click Computer-Restrictions-StandardWorkstations under Group Policy Object
2. Details Tab, GPO Status, User configuration settings disabled

## Link to the three non-IT department Computers OUs
1. Right click Finance, Computers, OU, Link an Existing GPO, Select Computer-Restrictions-StandardWorkstations, OK
2. Do the same for both Sales and HR
