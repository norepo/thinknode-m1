param(
    [string]$Tag = "",
    [string]$Title = "",
    [string]$Notes = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path "$PSScriptRoot\..").Path

if (-not $Tag) {
    $dateStamp = Get-Date -Format "yyyyMMdd"
    $Tag = "v1.18.0-$dateStamp"
}

if (-not $Title) {
    $Title = "MeshCore 1.18 - Release $Tag"
}

# Run packaging script first
& "$PSScriptRoot\package-release.ps1" -Tag $Tag

$releasesDir = Join-Path $repoRoot "releases"
$bleZip = Join-Path $releasesDir "thinknode-m1-companion-ble-$Tag.zip"
$usbZip = Join-Path $releasesDir "thinknode-m1-companion-usb-$Tag.zip"

if (-not (Test-Path $bleZip) -or -not (Test-Path $usbZip)) {
    Write-Error "Release archives could not be found."
}

$notesFile = Join-Path $env:TEMP "release_notes_$Tag.md"
if (-not $Notes) {
    @"
## MeshCore 1.18 Firmware Release ($Tag)

Precompiled binaries and standalone flashing packages for **Elecrow ThinkNode M1** (Nordic nRF52840 + Semtech SX1262 LoRa + 1.54" SSD1681 E-Ink + L76K GPS).

### Key Fixes & Improvements / Kluczowe Poprawki
1. **Ekran E-Ink nie gaśnie / Persistent E-Ink Display**:
   - Wyłączono automatyczny 15-sekundowy timeout interfejsu (`AUTO_OFF_MILLIS=0`). Ekran pozostaje stale czytelny (bi-stability).
   - Usunięto destrukcyjne czyszczenie buforów do bieli (`clearScreen(0xFF)`) w sterowniku `GxEPDDisplay` przy uśpieniu/wyłączeniu zasilania.
   - Odświeżanie statystyk sensora i zegara raz na 60 sekund w celu eliminacji niepożądanego migotania e-papieru.
2. **Sterowanie podświetleniem (Frontlight)**:
   - Skonfigurowano `BACKLIGHT_BTN=PIN_BUTTON2` — kliknięcie przycisku w pokrętle włącza/wyłącza podświetlenie frontlight bez wpływu na treść wyświetlaną na e-papierze.
3. **Pakiety instalacyjne**:
   - Pliki `.uf2` gotowe do przeciągnięcia na dysk USB po dwukrotnym kliknięciu RESET.
   - Pliki `.hex` i `.zip` dla programatorów J-Link oraz DFU OTA / Web Flasher.

### Quick Start / Szybki Start (UF2)
1. Pobierz paczkę ZIP (BLE lub USB) i rozpakuj.
2. Kliknij dwukrotnie przycisk **RESET** na obudowie ThinkNode M1 (urządzenie zamontuje się jako dysk USB, np. `NRF52BOOT`).
3. Przeciągnij plik `firmware.uf2` na wykryty dysk lub uruchom `flash-uf2.bat`.
"@ | Set-Content -Path $notesFile -Encoding UTF8
} else {
    $Notes | Set-Content -Path $notesFile -Encoding UTF8
}

Write-Host "Publishing GitHub Release: $Tag..." -ForegroundColor Cyan
gh release create $Tag $bleZip $usbZip --title "$Title" --notes-file "$notesFile"

if (Test-Path $notesFile) { Remove-Item -Force $notesFile }

Write-Host "[SUCCESS] GitHub Release published successfully: $Tag" -ForegroundColor Green
