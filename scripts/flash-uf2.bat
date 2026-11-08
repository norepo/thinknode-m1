@echo off
setlocal
echo ==========================================================
echo   Elecrow ThinkNode M1 - Flashing Companion Radio (UF2)
echo ==========================================================
echo Double-click RESET on ThinkNode M1 to enter UF2 bootloader mode.
powershell.exe -ExecutionPolicy Bypass -File "%~dp0flash-uf2.ps1" %*
pause
