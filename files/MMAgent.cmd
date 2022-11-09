@echo off & setlocal
set batchPath=%~dp0
C:
powershell.exe "C:\Users\%username%\Documents\SULFURAX\Verification\MMAgent.ps1"

:: Clear CMD
timeout /t 5 /nobreak
cls
exit