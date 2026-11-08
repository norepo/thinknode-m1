# Elecrow ThinkNode M1 - Flashing Guide / Instrukcja Wgrywania

[English](#english) | [Polski](#polski)

---

<a id="english"></a>
## English

There are three ways to flash MeshCore firmware onto the ThinkNode M1:

### Method 1: UF2 Bootloader (Recommended)
This is the simplest and safest method. No software installation needed.
1. Connect the ThinkNode M1 to your computer via USB-C.
2. Quickly **double-click the RESET button** on the device.
3. The device will mount as a mass storage drive (usually named `NRF52BOOT` or `THINKNODE`).
4. Drag and drop `firmware.uf2` directly onto this drive (or run `scripts/flash-uf2.bat`).
5. The device will flash itself and automatically reboot with the new firmware.

### Method 2: adafruit-nrfutil (Serial DFU)
1. Install `adafruit-nrfutil`:
   ```bash
   pip install adafruit-nrfutil
   ```
2. Put the device into DFU mode or use automatic 1200 bps touch reset:
   ```bash
   scripts\flash-nrfutil.bat -Port COM3
   ```

### Method 3: PlatformIO CLI
From the `MeshCore-dev` directory:
```bash
pio run -e ThinkNode_M1_companion_radio_ble -t upload
```

---

<a id="polski"></a>
## Polski

### Metoda 1: Przeciągnięcie pliku UF2 (Zalecana)
1. Podłącz ThinkNode M1 do komputera przewodem USB-C.
2. Kliknij **dwukrotnie przycisk RESET** na urządzeniu.
3. W systemie pojawi się dysk USB (np. `NRF52BOOT`).
4. Przeciągnij plik `firmware.uf2` na ten dysk (lub uruchom skrypt `scripts/flash-uf2.bat`).
5. Po skopiowaniu ThinkNode M1 automatycznie uruchomi nowy firmware.
