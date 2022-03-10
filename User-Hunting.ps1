# FIND ALL MACHINES ON THE CURRENT DOMAIN WHERE THE CURRENT USER HAS LOCAL ADMIN ACCESS
Find-LocalAdminAccess -Verbose

Can also be done with the help of remote admin tools like WMI and PowerShellRemoting. Usefull in cases ports RPC and SMB are blocked
Import-Module Find-WMILocalAdminAccess.ps1 && Find-PSRemotingLocalAdminAccess.ps1

Find-WMILocalAdminAccess
Find-PSRemotingLocalAdminAccess

# FIND COMPUTERS WHERE A DOMAIN ADMIN (OR SPECIFIED USER/GROUP HAS SESSIONS)
Find-DomainUserLocation -Verbose
Find-DomainUserLocation -UserGroupIdentity "RDPUsers"

# FIND COMPUTERS WHERE A DOMAIN ADMIN SESSION IS AVAILABLE AND CURRENT USER HAS ADMIN ACCESS 
Find-DomainUserLocation -CheckAccess

# FIND COMPUTERS (File Servers and Distributed File Servers) WHERE A DOMAIN SESSION IS AVAILABLE // Stealth option
Find-DomainUserLocation -Stealth 
