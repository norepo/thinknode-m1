@echo off
setlocal
echo ==========================================================
echo   Elecrow ThinkNode M1 - Packaging Release Archives
echo ==========================================================
powershell.exe -ExecutionPolicy Bypass -File "%~dp0package-release.ps1" %*
pause
