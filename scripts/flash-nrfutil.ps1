param (
    [string]$Variant = "ble",
    [string]$Port = ""
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

$fwSubdir = if ($Variant -eq "usb") { "02-companion-radio-usb" } else { "01-companion-radio-ble" }
$FwDir = Join-Path $ProjectRoot "firmware\$fwSubdir"
$ZipPackage = Join-Path $FwDir "firmware.zip"

if (-not (Test-Path $ZipPackage)) {
    Write-Error "Firmware DFU ZIP package not found: $ZipPackage"
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Elecrow ThinkNode M1 - Flashing via adafruit-nrfutil" -ForegroundColor Cyan
Write-Host "  Variant: $Variant" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Locate adafruit-nrfutil
$nrfutil = "$env:USERPROFILE\.platformio\packages\tool-adafruit-nrfutil\adafruit-nrfutil.exe"
if (-not (Test-Path $nrfutil)) {
    $cmd = Get-Command "adafruit-nrfutil" -ErrorAction SilentlyContinue
    if ($cmd) {
        $nrfutil = $cmd.Source
    } else {
        Write-Error "adafruit-nrfutil not found. Please install via: pip install adafruit-nrfutil"
    }
}

if (-not $Port) {
    Write-Host "Detecting available serial ports..." -ForegroundColor Yellow
    [System.IO.Ports.SerialPort]::getportnames() | ForEach-Object { Write-Host " - $_" }
    $Port = Read-Host "Enter COM port (e.g. COM3)"
    if (-not $Port) {
        Write-Error "No serial port provided. Aborting."
    }
}

Write-Host "Flashing $ZipPackage to $Port..." -ForegroundColor Cyan
& $nrfutil --verbose dfu serial --package $ZipPackage -p $Port -b 115200 --single-bank --touch 1200
Write-Host "[SUCCESS] Flashing complete!" -ForegroundColor Green
