@echo off
setlocal
echo ==========================================================
echo   Elecrow ThinkNode M1 - Flashing Companion Radio (DFU)
echo ==========================================================
powershell.exe -ExecutionPolicy Bypass -File "%~dp0flash-nrfutil.ps1" %*
pause
