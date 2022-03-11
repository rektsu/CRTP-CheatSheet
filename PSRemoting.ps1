- PowerShell Remoting (PSRemoting) same as psexec on steroids but more silent and super fast
- Uses WinRM
- May need to enable remoting (Enable-PSRemoting) on a Desktop Windows Machine (admin privs required)


# ONE-TO-ONE
Usefull Commands 

# ENTER PSSESSION
  Enter-PSSession dcorp-adminsrv
  
# GET PS HOST PROCESS INFO
  Get-PSHostProcessInfo (while on an alive session)
  
# SAVE SESSION IN A VARIABLE
  $adminsrv = New-PSSession dcorp-adminsrv
  
# INTERACT WITH SESSION
  Enter-PSSession -Session $adminsrv
  
# ONE TO MANY
# INVOKE COMMAND
  Invoke-Command -ScriptBlock{whoami;Get-Host} -ComputerName dcorp-adminsrv // Can specify a list of computer names.
  Invoke-Command -ScriptBlock{whoami;Get-Host} -ComputerName (cat C:\AD\Tools\comps.txt)
  Invoke-Command -ScriptBlock{Get-Process} -ComputerName (Get-Content <list_of_servers>)
 
# PASSING HASHES, USING CREDENTIALS AND EXECUTING COMMANDS ON MULTIPLE REMOTE COMPUTERS
  -Credential parameter to pass username/password
   Enter-PSSession -Session $aminsrv -Credential (Get-Credential) (Enter usernam/password) manually

# RUN LOCALLY LOADED SCRIPTS IN REMOTE MACHINES
  Invoke-Command -FilePath C:\scripts\Get-PassHashes.ps1 -ComputerName (Get-Content <list_of_servers>)
 
# RUN LOCALLY LOADED FUNCTIONS IN REMOTE MACHINES
  1. Get-PSProvider
  2. ls function: (To see functions loaded in the actual PowerShell session) // AVOID ERRORS ls function wont work ->  "ls function:" ->:<- 

  Invoke-Command -ScriptBlock ${function:Get-PassHashes} -ComputerName (Get-Content <list_of_servers>)
  
  Invoke-Command -Session $adminsrv -ScriptBlock{hostname;whoami}
  
  
  -> KERBEROS DOUBLE HOP ISSUE <- 
  Bypass -> Use explicit credentials in clear text in 2nd HOP
         -> Use credSSP in 1st machine (1st hop)
         -> Use delegation in 1st machine
         
  Anything with explicit credentials from 1st machine to 2nd machine (2nd hop) will work.
  
  
  
  -> IF TARGET ORGANIZATIONS USE ENHANCED POWERSHELL LOGIN <-
  
  1. DON'T USE POWERSHELL REMOTING PSRemoting
  2. USE WINRS (STILL REAP THE BENEFIT OF 5985)
  
  winrs -remote:server1 -u:server1\administrator -p:Pass@1234 hostname
  winrs -r:dcorp-adminsrv cmd
  
