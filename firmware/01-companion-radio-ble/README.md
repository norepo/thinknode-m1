# ThinkNode M1 - Companion Radio (BLE) Firmware

[English](#english) | [Polski](#polski)

---

<a id="english"></a>
## English
Precompiled **MeshCore 1.18** Companion Radio firmware with Bluetooth Low Energy (BLE) interface for the **Elecrow ThinkNode M1**.

### Included Files
- `firmware.uf2`: Drag-and-drop firmware for Adafruit / nRF52 bootloader (double-click RESET to enter).
- `firmware.hex`: Full Intel HEX image with SoftDevice S140 merge for J-Link / programmer.
- `firmware.zip`: DFU package for `adafruit-nrfutil`.

### Configuration
- **Bluetooth PIN**: `123456`
- **Display**: 1.54" SSD1681 E-Ink (`GxEPDDisplay`, Rotation 4, `AUTO_OFF_MILLIS=0`)
- **Frontlight Control**: Button 2 (`PIN_BUTTON2`) toggles LED frontlight
- **GPS**: L76K GNSS enabled (`ENV_INCLUDE_GPS=1`)

---

<a id="polski"></a>
## Polski
Skompilowany firmware MeshCore 1.18 wariantu Companion Radio (BLE) dla urządzenia ThinkNode M1 z trwałym wyświetlaczem E-Ink.
- Kod parowania BLE: `123456`
- Ekran nie gaśnie po bezczynności.
