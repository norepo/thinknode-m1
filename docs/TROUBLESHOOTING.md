# ThinkNode M1 - Troubleshooting & Technical Notes

[English](#english) | [Polski](#polski)

---

<a id="english"></a>
## English

### 1. E-Ink Screen Blanking After Inactivity (Resolved)
- **Symptom**: In stock MeshCore 1.18, the screen cleared to blank white after 15 seconds of inactivity.
- **Cause**: Missing `-D AUTO_OFF_MILLIS=0` in `platformio.ini` caused the general UI timeout to trigger `turnOff()`, which called `clearScreen(0xFF)`.
- **Resolution**: Firmware in this repository sets `AUTO_OFF_MILLIS=0` and removes the destructive screen clearing, keeping the display continuously visible with low power consumption.

### 2. Bluetooth Pairing Code
- The static pairing PIN code for Bluetooth Low Energy is: **`123456`**.

### 3. GPS Operation
- The ThinkNode M1 features a dedicated physical GPS toggle switch (`PIN_GPS_SWITCH`).
- Make sure the slide switch is ON to power up the Quectel L76K module (`GPS_EN` = High).

### 4. Frontlight Toggle
- Pressing the rotary encoder knob (`PIN_BUTTON2`) toggles the LED frontlight on/off.

---

<a id="polski"></a>
## Polski

### 1. Wygaszanie ekranu E-Ink (Rozwiązane)
- **Problem**: Ekran gasł po kilkunastu sekundach bezczynności po naciśnięciu przycisku.
- **Rozwiązanie**: Firmware w tym repozytorium wyłącza automatyczny timeout (`AUTO_OFF_MILLIS=0`) oraz zachowuje bufor ekranu przy uśpieniu, dzięki czemu ekran pozostaje stale czytelny.

### 2. Kod PIN Bluetooth
- Domyślny kod parowania BLE z aplikacją MeshCore w telefonie to: **`123456`**.

### 3. Działanie GPS
- Urządzenie posiada fizyczny suwak włączania GPS. Upewnij się, że przełącznik jest w pozycji ON, aby odbiornik L76K otrzymywał zasilanie.
