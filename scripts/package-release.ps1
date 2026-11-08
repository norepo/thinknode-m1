param(
    [string]$Tag = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path "$PSScriptRoot\..").Path
$releasesDir = Join-Path $repoRoot "releases"

if (-not (Test-Path $releasesDir)) {
    New-Item -ItemType Directory -Path $releasesDir | Out-Null
}

if (-not $Tag) {
    $dateStamp = Get-Date -Format "yyyyMMdd"
    $Tag = "v1.18.0-$dateStamp"
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Packaging ThinkNode M1 Releases: $Tag" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Package Companion Radio (BLE)
$bleZipName = "thinknode-m1-companion-ble-$Tag.zip"
$bleZipPath = Join-Path $releasesDir $bleZipName
$bleTempDir = Join-Path $env:TEMP "thinknode-ble-$Tag"

if (Test-Path $bleTempDir) { Remove-Item -Recurse -Force $bleTempDir }
New-Item -ItemType Directory -Path $bleTempDir | Out-Null

Copy-Item "$repoRoot\firmware\01-companion-radio-ble\*" $bleTempDir -Force
Copy-Item "$repoRoot\scripts\flash-uf2.bat" $bleTempDir -Force
Copy-Item "$repoRoot\scripts\flash-uf2.ps1" $bleTempDir -Force
Copy-Item "$repoRoot\scripts\flash-nrfutil.bat" $bleTempDir -Force
Copy-Item "$repoRoot\scripts\flash-nrfutil.ps1" $bleTempDir -Force
Copy-Item "$repoRoot\scripts\monitor-serial.bat" $bleTempDir -Force
if (Test-Path "$repoRoot\docs\TROUBLESHOOTING.md") {
    Copy-Item "$repoRoot\docs\TROUBLESHOOTING.md" $bleTempDir -Force
}

if (Test-Path $bleZipPath) { Remove-Item -Force $bleZipPath }
Compress-Archive -Path "$bleTempDir\*" -DestinationPath $bleZipPath -CompressionLevel Optimal
Remove-Item -Recurse -Force $bleTempDir

Write-Host "[OK] Created BLE Companion release bundle: $bleZipPath" -ForegroundColor Green

# Package Companion Radio (USB)
$usbZipName = "thinknode-m1-companion-usb-$Tag.zip"
$usbZipPath = Join-Path $releasesDir $usbZipName
$usbTempDir = Join-Path $env:TEMP "thinknode-usb-$Tag"

if (Test-Path $usbTempDir) { Remove-Item -Recurse -Force $usbTempDir }
New-Item -ItemType Directory -Path $usbTempDir | Out-Null

Copy-Item "$repoRoot\firmware\02-companion-radio-usb\*" $usbTempDir -Force
Copy-Item "$repoRoot\scripts\flash-uf2.bat" $usbTempDir -Force
Copy-Item "$repoRoot\scripts\flash-uf2.ps1" $usbTempDir -Force
Copy-Item "$repoRoot\scripts\flash-nrfutil.bat" $usbTempDir -Force
Copy-Item "$repoRoot\scripts\flash-nrfutil.ps1" $usbTempDir -Force
Copy-Item "$repoRoot\scripts\monitor-serial.bat" $usbTempDir -Force
if (Test-Path "$repoRoot\docs\TROUBLESHOOTING.md") {
    Copy-Item "$repoRoot\docs\TROUBLESHOOTING.md" $usbTempDir -Force
}

if (Test-Path $usbZipPath) { Remove-Item -Force $usbZipPath }
Compress-Archive -Path "$usbTempDir\*" -DestinationPath $usbZipPath -CompressionLevel Optimal
Remove-Item -Recurse -Force $usbTempDir

Write-Host "[OK] Created USB Companion release bundle: $usbZipPath" -ForegroundColor Green

Get-Item $bleZipPath, $usbZipPath | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
