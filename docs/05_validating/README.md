# Validating the Policies

## Password and Account Lockout
1. Run this command and verify that the information is that same as you policy
```shell
Get-ADDefaultDomainPasswordPolicy
```

2. Go to Active Directory Users and Computers
- Select a user within you company and try adn change their password to a weak password
- It should respond with an error saying that Windows cannot chang ethe password because it doesnt meet the password policy requirements

## Control Panel Restriction
1. Sign into a user within the department that the GPO is set.
2. Search for control panel and try to access iot
3. You should recieve a message saying the operation was canceled due to restrictions on the computer