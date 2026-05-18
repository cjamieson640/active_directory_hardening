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