#This script deaktivates the online search fuction in Windows start menu.

#Set/Create BingSeachEnabled Value
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -type DWord

#Set/Create CortanaConsent Value
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0 -type DWord

#Restart Computer
Shurtdown.exe /r /t 2
