    choco upgrade ultradefrag -y
choco upgrade sdelete -y

net stop wuauserv
rmdir /S /Q C:\Windows\SoftwareDistribution\Download
mkdir C:\Windows\SoftwareDistribution\Download
net start wuauserv

cmd /c udefrag --optimize --repeat C:

cmd /c %SystemRoot%\System32\reg.exe ADD HKCU\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f
cmd /c sdelete.exe -q -z C:

choco uninstall ultradefrag -y
choco uninstall sdelete -y

