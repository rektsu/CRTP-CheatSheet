# Learning Objective 1

# Enumerate following for the dollarcorp domain

- Users
  Get-DomainUser -domain dollarcorp.moneycorp.local | select name
  
- Computers
  Get-DomainComputer -domain dollarcorp.moneycorp.local | select name
  
- Domain Administrators
  Get-DomainGroupMember -domain dollarcorp.moneycorp.local -Identity "Domain Admins" -Recurse | select MemberName
  
- Enterprise Administrators
  Get-DomainGroupMember -domain moneycorp.local -Identity "Enterprise Admins" -Recurse | select MemberName
