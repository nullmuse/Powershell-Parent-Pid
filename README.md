# Powershell-Parent-Pid
Get parent process pids of running processes without having to rely on WMI

After downloading script, import cmdlet via 
. .\Get-ProcessParent.ps1

It can then be called via 

Get-ProcessParent 

Output snippet: 

764:services --> PPID:688
772:lsass --> PPID:688
864:svchost --> PPID:764
916:winlogon --> PPID:680
988:svchost --> PPID:764
428:dwm --> PPID:916
760:svchost --> PPID:764
896:svchost --> PPID:764
1060:svchost --> PPID:764
1064:svchost --> PPID:764
1216:svchost --> PPID:764
1264:nvvsvc --> PPID:764
1272:nvscpapisvr --> PPID:764
1312:svchost --> PPID:764
