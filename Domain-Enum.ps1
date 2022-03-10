# With ADModule or PowerView, BloodHound or SharpView

# DOMAIN GENERAL INFO

Get-Domain -domain <domain>
Get-DomainSID -domain <domain>
Get-DomainPolicyData -domain <domain> // (Get-DomainPolicyData).systemaccess -domain <domain>

# CONTROLLER
Get-DomainController -domain <domain>

# USERS
Get-DomainUser -Identity <student575>
Get-DomainUser -Identity Administrator -Properties samaccountname,logonCount

# SEARCH STRING IN USER'S ATTRIBUTE
Get-DomainUser -LDAPFilter "Description=*built*" | Select name,description

# LIST COMPUTERS IN DOMAIN
Get-DomainComputer -domain <domain> | select name
Get-DomainComputer -domain <domain> -OperatingSystem "*Server 2016*"
Get-DomainComputer -Ping

# LIST GROUPS IN DOMAIN
Get-DomainGroup -domain <domain> | select name
Get-DomainGroup -Identity Administrators
Get-DomainGroup -Identity 'Allowed RODC Password Replication Group'
Get-DomainGroup *admin*

# LIST ALL MEMBERS OF ADMIN GROUP IN A DOMAIN
Get-DomainGroupMember -Identity "Domain Admins" -Recurse
Get-DomainGroupMember -domain moneycorp.local -Identity "Enterprise Admins" 

# GET GROUP MEMBERSHIP FOR A USER
Get-DomainGroup -UserName student575

# GET LOCAL GROUPS ON A MACHINE (needs admin privs on non-dc machines)
Get-NetLocalGroup -ComputerName dcorp-student575 -ListGroups

# GET ACTIVELY LOGGED USERS ON A COMPUTER (needs local admin rights on the target)
Get-NetLoggedon -ComputerName <servername>

# GET LOCALLY LOGGED USERS ON A COMPUTER (NEEDS REMOTE REGISTRY ON THE TARGET - STARTED BY-DEFAULT ON SERVER OS)
Get-NetLoggedonLocal -ComputerName <servername>

# FIND FILES
# FIND SHARES ON HOSTS IN CURRENT DOMAIN
Invoke-ShareFinder -verbose

# FIND SENSITIVE FILES ON COMPUTERS IN THE DOMAIN
Invoke-FileFinder -verbose

# FIND ALL FILESERVERS OF THE DOMAIN
Get-NetFileServer

# GPO ENUM
Get-DomainGPO
Get-DomainGPO | select displayname
Get-DomainGPO -domain <domain> -ComputerIdentity <dcorp-student575>

# OU ENUM
Get-DomainOU
Get-DomainOU | select name
Get-DomainOU -Identity <name>

// Get-DomainGPO -Identity "{3E04167E-C2B6-4A9A-8FB7-C811158DC97C}"


