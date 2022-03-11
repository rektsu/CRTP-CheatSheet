1. ALWAYS SET UP BLOODHOUND IN THE HOST MACHINE NEVER IN THE LAB OF THE EXAM THIS WAY YOU SAVE A LOT OF TIME
2. SUPPLY DATA (THIS IS WHAT YOU DO IN THE LAB)

-CollectionMethod All -> Noisy

1. Supply data to BloodHound (what you run in the LAB):

  a. From InvisiShell (PS)
  b. Import-Module .\SharpHound.ps1
    c. Invoke-BloodHound -CollectionMethod All
  OR
  b. SharpHound.exe
  
  The generated archive can be uploaded to the BloodHound application
  To avoid detections like ATA:
  
  Invoke-BloodHound -CollectionMethod All -ExcludeDc
  
  
Usefull Queries: (Set up yout hostname node)

1. Find all Domain Admins
2. Find shortest paths to Domain Admins
3. Search path in between two nodes (you and the domain admin).
4. Click the node of your machine and check Node Info (Local Admin Rights / Group Membership / OverWiev -> Reachable High Value Targets gives good ammount of info)
