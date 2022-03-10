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

# Learning Objective 2

- List all the OUs
  Get-DomainOU | select name

- List all the computers in the StudentMachines OU
  (Get-DomainOU -Identity StudentMachines).distinguishedname | %{Get-DomainComputer -SearchBase $_} | select name
  
- List the GPOs
  Get-DomainGPO | select -ExpandProperty displayname
  
- Enumerate GPO applied on the StudentMachines OU
  (Get-DomainOU -Identity StudentMachines).gplink
  Get-DomainGPO -Identity "{3E04167E-C2B6-4A9A-8FB7-C811158DC97C}"
  
