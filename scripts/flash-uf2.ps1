param (
    [string]$Variant = "ble",
    [string]$Drive = ""
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

$fwSubdir = if ($Variant -eq "usb") { "02-companion-radio-usb" } else { "01-companion-radio-ble" }
$FwDir = Join-Path $ProjectRoot "firmware\$fwSubdir"
$Uf2File = Join-Path $FwDir "firmware.uf2"

if (-not (Test-Path $Uf2File)) {
    Write-Error "Firmware UF2 file not found: $Uf2File"
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Elecrow ThinkNode M1 - Flashing via UF2 Bootloader" -ForegroundColor Cyan
Write-Host "  Variant: $Variant" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Find UF2 drive if not specified
if (-not $Drive) {
    Write-Host "Searching for connected UF2 bootloader drive (e.g. NRF52BOOT)..." -ForegroundColor Yellow
    $drives = Get-PSDrive -PSProvider FileSystem | Where-Object {
        $infoFile = Join-Path $_.Root "INFO_UF2.TXT"
        Test-Path $infoFile
    }

    if ($drives) {
        $Drive = $drives[0].Root
        Write-Host "Detected UF2 bootloader at drive: $Drive" -ForegroundColor Green
    } else {
        Write-Host "No UF2 bootloader drive detected automatically." -ForegroundColor Yellow
        Write-Host "Please put ThinkNode M1 into bootloader mode by DOUBLE-CLICKING the RESET button." -ForegroundColor Yellow
        $Drive = Read-Host "Enter the drive letter of the mounted bootloader (e.g. D: or E:)"
        if (-not $Drive) {
            Write-Error "No drive provided. Aborting."
        }
        if (-not $Drive.EndsWith("\")) { $Drive += "\" }
    }
}

if (-not (Test-Path $Drive)) {
    Write-Error "Target drive $Drive does not exist."
}

Write-Host "Copying $Uf2File to $Drive..." -ForegroundColor Cyan
Copy-Item -Path $Uf2File -Destination $Drive -Force
Write-Host "[SUCCESS] Firmware UF2 copied successfully!" -ForegroundColor Green
Write-Host "The ThinkNode M1 will now reboot automatically with the new MeshCore 1.18 firmware." -ForegroundColor Green
