@echo off
setlocal
echo ==========================================================
echo   Elecrow ThinkNode M1 - Serial Monitor (115200 baud)
echo ==========================================================
pio device monitor -b 115200
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo PlatformIO monitor not available. Please specify COM port:
    set /p PORT="Enter COM port (e.g. COM3): "
    powershell.exe -Command "$port = New-Object System.IO.Ports.SerialPort '%PORT%', 115200, None, 8, one; $port.Open(); while($true){ Write-Host -NoNewline $port.ReadExisting(); Start-Sleep -Milliseconds 50 }"
)
pause
