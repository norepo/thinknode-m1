# Elecrow ThinkNode M1 - MeshCore Firmware & Tools

[English](#english) | [Polski](#polski)

[![Hardware](https://img.shields.io/badge/Hardware-Elecrow%20ThinkNode%20M1-orange.svg)](https://elecrow.com)
[![MCU](https://img.shields.io/badge/MCU-Nordic%20nRF52840%20(ARM%20Cortex--M4)-blue.svg)](https://nordicsemi.com)
[![Display](https://img.shields.io/badge/Display-1.54%22%20E--Ink%20(SSD1681)-lightgrey.svg)](https://elecrow.com)
[![Radio](https://img.shields.io/badge/LoRa-Semtech%20SX1262%20(+22dBm)-green.svg)](https://semtech.com)
[![GPS](https://img.shields.io/badge/GPS-Quectel%20L76K-red.svg)](https://quectel.com)
[![MeshCore](https://img.shields.io/badge/MeshCore-v1.18.0-purple.svg)](https://github.com/meshcore-dev/MeshCore)

---

<a id="english"></a>
## English

Project repository containing precompiled **MeshCore 1.18** firmware, flashing tools, hardware configurations, and patch sets for the **Elecrow ThinkNode M1**.

### E-Ink Display Blanking Fix (Firmware 1.18)
In upstream MeshCore 1.18.0 on the ThinkNode M1, the e-ink display turned off (cleared to white) 15 seconds after the last button press. This occurred because:
1. `-D AUTO_OFF_MILLIS=0` was missing from `variants/thinknode_m1/platformio.ini`, triggering the default 15s inactivity screen timeout.
2. In `GxEPDDisplay::turnOff()`, calling `display.clearScreen(0xFF)` forcibly erased the screen to blank white instead of retaining the bistable e-paper image.

**Fix Applied**:
- Configured `-D AUTO_OFF_MILLIS=0` so the UI does not trigger display timeout.
- Telemetry & clock refresh rate set to 60s for e-ink (avoiding unwanted screen flickering).
- Removed screen wipe in `GxEPDDisplay::turnOff()` so the display retains the last frame upon hibernation or power off.
- Configured `-D BACKLIGHT_BTN=PIN_BUTTON2` allowing the rotary knob button to toggle the frontlight on/off.

### Directory Organization

```
thinknode-m1/
├── firmware/
│   ├── 01-companion-radio-ble/        # Bluetooth Low Energy Companion Radio
│   │   ├── firmware.uf2               # UF2 drag-and-drop binary (~724 KB)
│   │   ├── firmware.hex               # Intel HEX binary with SoftDevice S140
│   │   ├── firmware.zip               # DFU OTA / nrfutil package
│   │   └── README.md
│   └── 02-companion-radio-usb/        # USB Serial Companion Radio
│       ├── firmware.uf2               # UF2 drag-and-drop binary (~706 KB)
│       ├── firmware.hex               # Intel HEX binary
│       ├── firmware.zip               # DFU package
│       └── README.md
├── scripts/
│   ├── flash-uf2.bat / .ps1           # Automated UF2 drive detection & flashing
│   ├── flash-nrfutil.bat / .ps1       # Serial DFU flashing via adafruit-nrfutil
│   ├── monitor-serial.bat             # 115200 baud serial monitor
│   ├── package-release.bat / .ps1     # Package standalone ZIP release bundles
│   └── publish-github-release.ps1     # Automated GitHub Release publisher
├── config/
│   ├── platformio.ini                 # ThinkNode M1 board build flags
│   ├── target.h / target.cpp          # Radio & sensor bindings
│   ├── ThinkNodeM1Board.h / .cpp      # Hardware board definition
│   └── variant.h / variant.cpp        # nRF52840 pin assignments
├── patches/
│   └── 01-thinknode-m1-eink-display-fix-and-backlight.patch
├── docs/
│   ├── HARDWARE_PINOUT.md             # Complete pin assignments & schematics
│   ├── FLASHING_GUIDE.md              # Detailed flashing walk-through
│   └── TROUBLESHOOTING.md             # Diagnostics, GPS, and BLE PIN notes
└── .github/workflows/
    └── release.yml                    # Automated release workflow on PR / Tag
```

### Quick Start: Flashing via UF2 (Recommended)
1. Download the release archive or navigate to `firmware/01-companion-radio-ble/`.
2. Connect ThinkNode M1 to PC with USB-C.
3. **Double-click the RESET button** on the device to enter bootloader mode (mounted as `NRF52BOOT` drive).
4. Run `scripts\flash-uf2.bat` or drag `firmware.uf2` onto the detected drive.
5. The device will automatically reboot with the new firmware!

---

<a id="polski"></a>
## Polski

Repozytorium zawierające skompilowany firmware **MeshCore 1.18**, skrypty instalacyjne oraz dokumentację sprzętową dla **Elecrow ThinkNode M1**.

### Rozwiązanie problemu wygaszania ekranu E-Ink
W fabrycznym firmware MeshCore 1.18 ekran e-ink gasł po kilkunastu sekundach bezczynności po każdym naciśnięciu przycisku.
- **Przyczyna**: Brak flagi `AUTO_OFF_MILLIS=0` powodował wywoływanie `turnOff()`, które czyściło bufor ekranu do bieli (`clearScreen(0xFF)`).
- **Poprawka**: Ustawiono `AUTO_OFF_MILLIS=0`, usunięto czyszczenie buforów z metody `turnOff()` oraz dodano sterowanie podświetleniem frontlight pokrętłem (`BACKLIGHT_BTN=PIN_BUTTON2`).

### Szybki start (UF2)
1. Podłącz ThinkNode M1 kablem USB do komputera.
2. Wciśnij szybko **dwukrotnie przycisk RESET**.
3. Uruchom `scripts\flash-uf2.bat` lub przeciągnij plik `firmware/01-companion-radio-ble/firmware.uf2` na wykryty dysk USB (`NRF52BOOT`).
4. Urządzenie zrestartuje się z poprawionym firmware, a ekran e-ink pozostanie stale czytelny.
