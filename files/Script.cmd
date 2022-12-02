@echo off
color 03
Mode 130,45
C:

:: Reset rules firewall (for people who bypass with)
netsh advfirewall reset 

:: Fix double click Mouse
Reg.exe add "HKCU\Control Panel\Mouse" /v "DoubleClickSpeed" /t REG_SZ /d "500" /f

:: Fix start ctfmon
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "ctfmon" /t REG_SZ /d "\"C:\Windows\System32\ctfmon.exe\"" /f

:: Disable Hiberboot
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f

:: Start AppInfo Service
sc config AppInfo start=auto
sc start AppInfo

:: Start BAM Service
sc config BAM start= AUTO
sc start BAM start

:: Start BITS Service
sc config BITS start=auto
sc start BITS

:: Start CDPUserSvc_1675c6 Service
sc config CDPUserSvc_1675c6 start=auto
sc start CDPUserSvc_1675c6

:: Start CDPSvc Service
sc config CDPSvc start=auto
sc start CDPSvc

:: Start DiagTrack Service
sc config DiagTrack start= AUTO
sc start DiagTrack start

:: Start DNS Service
sc config dnscache start= AUTO
sc start dnscache start

:: Start DPS Service
sc config DPS start= AUTO
sc start DPS start

:: Start Dusmsvc Service
sc config Dusmsvc start= AUTO
sc start Dusmsvc start

:: Start Eventlog Service
sc config Eventlog start= AUTO
sc start Eventlog start

:: Start PCA Service
sc config PcaSvc start= AUTO
sc start PcaSvc start

:: Start SGRMBroker Service
sc config SGRMBroker start= AUTO
sc start SGRMBroker

:: Start SysMain/Superfetch Service
sc config SysMain start= AUTO
sc start SysMain start

:: Start WSearch Service
sc config WSearch start= AUTO
sc start WSearch

:: Clear CMD
timeout /t 5 /nobreak
cls
exit