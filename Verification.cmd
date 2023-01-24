:: Copyright (C) 2022 SULFURAX1.0
:: 
:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the GNU Affero General Public License as published
:: by the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
:: 
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU Affero General Public License for more details.
:: 
:: You should have received a copy of the GNU Affero General Public License
:: along with this program.  If not, see <https://www.gnu.org/licenses/>.

@echo off
color 03
Mode 130,45
title Script Verification - 1.4
setlocal EnableDelayedExpansion

C:

:: Disable LUA
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f

:: Dossier
mkdir C:\SULFURAX\Verification >nul 2>&1
mkdir C:\SULFURAX\Backup >nul 2>&1
cd C:\SULFURAX\Verification >nul 2>&1

:: Run Admin
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

:: Show details BSOD
Reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

:: Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

:: Add ANSI escape sequences
Reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:: Check Updates
goto CheckUpdates

:CheckUpdates
set local=1.4
set localtwo=%local%
if exist "%temp%\Updater.bat" DEL /S /Q /F "%temp%\Updater.bat" >nul 2>&1
curl -g -L -# -o "%temp%\Updater.bat" "https://raw.githubusercontent.com/SULFURA/Verification/main/files/Verification_Version" >nul 2>&1
call "%temp%\Updater.bat"
IF "%local%" gtr "%localtwo%" (
	cls
	Mode 65,16
	echo.
	echo                        You need to Update
    echo                         - Verification -
	echo  ______________________________________________________________
	echo.
	echo                       Current version: %localtwo%
	echo.
	echo                         New version: %local%
	echo.
	echo  ______________________________________________________________
	echo.
	echo      [ Y ] To Update Verification
	echo.
	echo      [ N ] Skip Update
	echo.
	%SystemRoot%\System32\choice.exe /c:YN /n /m "%DEL%                                >:"
	set choice=!errorlevel!
	if !choice! equ 1 (
		curl -L -o %0 "https://github.com/SULFURA/Verification/releases/latest/download/Verification.cmd" >nul 2>&1
		call %0
		exit /bUsers
	)
	Mode 130,45
)

:: Restore Point
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'Verification Restore Point' >nul 2>&1

::HKCU & HKLM backup
for /F "tokens=2" %%i in ('date /t') do set date=%%i
set date1=%date:/=.%
>nul 2>&1 md C:\SULFURAX\Backup\%date1%
reg export HKCU C:\SULFURAX\Backup\%date1%\HKLM.reg /y >nul 2>&1
reg export HKCU C:\SULFURAX\Backup\%date1%\HKCU.reg /y >nul 2>&1

:: Script
cls
goto Script 
title Script en cours...

:Script

::NSudo
goto NSudo
:NSudo
C:
rmdir /S /Q "C:\SULFURAX\Verification\"
curl -g -L -# -o "C:\SULFURAX\Verification\NSudo.exe" "https://github.com/SULFURA/Verification/raw/main/files/NSudo.exe"

:: Script
goto Verif

:Verif
cls
curl -g -L -# -o "C:\SULFURAX\Verification\Script.cmd" "https://raw.githubusercontent.com/SULFURA/Verification/main/files/Script.cmd"
cd "C:\SULFURAX\Verification\"
NSudo.exe -U:T -P:E "C:\SULFURAX\Verification\Script.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 10 /nobreak

:: MMAgent
goto MMAgent

:MMAgent
cls
curl -g -L -# -o "C:\SULFURAX\Verification\MMAgent.cmd" "https://raw.githubusercontent.com/SULFURA/Verification/main/files/MMAgent.cmd"
curl -g -L -# -o "C:\SULFURAX\Verification\MMAgent.ps1" "https://raw.githubusercontent.com/SULFURA/Verification/main/files/MMAgent.ps1"
cd "C:\SULFURAX\Verification\"
start MMAgent.cmd
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 10 /nobreak

:: End
goto End

:End
cls
echo Fin du Script
title Fin du Script

:: Clear CMD + Exit
timeout /t 5 /nobreak
cls
exit

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul  
goto :eof