@echo off & setlocal
set batchPath=%~dp0
C:
powershell.exe "C:\SULFURAX\Verification\MMAgent.ps1"

:: Clear CMD
timeout /t 5 /nobreak
cls
exit