@echo off
setlocal enabledelayedexpansion
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
sc config BAM start= auto
sc start BAM 

:: Start bfe service
sc config bfe start= auto
sc start bfe 

:: Start BITS Service
sc config BITS start=auto
sc start BITS

:: Start CDPUserSvc_[numbers] Service
for /f "tokens=2 delims=:" %%a in ('sc query state^= all ^| findstr /i "cdpuser"') do (
    set serviceName=%%a
)

sc config %serviceName% start= auto
reg add "HKLM\SYSTEM\CurrentControlSet\Services\%serviceName%" /v Start /t REG_DWORD /d 2 /f
sc start %serviceName%

:: Start CDPSvc Service
sc config CDPSvc start=auto
sc start CDPSvc

:: Start DiagTrack Service
sc config DiagTrack start= auto
sc start DiagTrack 

:: Start DNS Service
sc config dnscache start= auto
sc start dnscache 

:: Start DPS Service
sc config DPS start= auto
sc start DPS 

:: Start Dusmsvc Service
sc config Dusmsvc start= auto
sc start Dusmsvc 

:: Start Eventlog Service
sc config Eventlog start= auto
sc start Eventlog 

:: Start KeyIso Service
sc config KeyIso start= auto
sc start KeyIso 

:: Start mpssvc Service
sc config mpssvc start= auto
sc start mpssvc

:: Start PCA Service
sc config PcaSvc start= auto
sc start PcaSvc 

:: Start SGRMBroker Service
sc config SGRMBroker start= auto
sc start SGRMBroker

:: Start Smartscreen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreferOnlineApps /t REG_DWORD /d 1 /f

:: Start SysMain/Superfetch Service
sc config SysMain start= auto
sc start SysMain 

:: Start umrdpservice Service
sc config umrdpservice start= auto
sc start umrdpservice 

:: Start Windows Defender
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 0 /f
sc config Windefend start= auto
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Windefend" /v Start /t REG_DWORD /d 2 /f
sc start Windefend

:: Start WSearch Service
sc config WSearch start= auto
sc start WSearch

:: Clear CMD
timeout /t 5 /nobreak
cls
exit