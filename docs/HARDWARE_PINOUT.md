# Elecrow ThinkNode M1 - Hardware Pinout & Architecture

[English](#english) | [Polski](#polski)

---

<a id="english"></a>
## English

### System Overview
The **Elecrow ThinkNode M1** is an all-in-one handheld LoRa mesh communicator powered by the Nordic nRF52840 SoC.

| Component | Specification |
| :--- | :--- |
| **MCU** | Nordic Semiconductor nRF52840 (ARM Cortex-M4F @ 64 MHz, 1 MB Flash, 256 KB RAM) |
| **LoRa Radio** | Semtech SX1262 (+22 dBm TX power) |
| **Display** | 1.54-inch 200x200 Monochrome E-Ink / EPD (SSD1681 driver IC) |
| **Frontlight** | LED Frontlight illumination on pin `P1.11` (D43) |
| **GNSS / GPS** | Quectel L76K GNSS module (UART Serial1 @ 9600 baud) |
| **Controls** | Rotary encoder + push-switch (`PIN_BUTTON2` = D11), User button (`PIN_BUTTON1` = D42) |
| **Flash** | 2 MB External QSPI Flash (MX25R1635F) |
| **Battery** | Built-in 1200 mAh LiPo, ADC voltage divider on pin D4 |

### Pin Assignments

#### LoRa Radio (Semtech SX1262)
- `P_LORA_NSS`: Pin 24 (`P0.24`)
- `P_LORA_DIO_1`: Pin 20 (`P0.20`)
- `P_LORA_RESET`: Pin 25 (`P0.25`)
- `P_LORA_BUSY`: Pin 17 (`P0.17`)
- `P_LORA_SCLK`: Pin 19 (`P0.19`)
- `P_LORA_MOSI`: Pin 22 (`P0.22`)
- `P_LORA_MISO`: Pin 23 (`P0.23`)
- `SX126X_POWER_EN`: Pin 37 (`P1.05`)
- `P_LORA_TX_LED`: Pin 13 (`P0.13`)

#### E-Ink Display (1.54" SSD1681 SPI)
- `DISP_CS`: Pin 30 (`P0.30`)
- `DISP_DC`: Pin 28 (`P0.28`)
- `DISP_RST`: Pin 2 (`P0.02`)
- `DISP_BUSY`: Pin 3 (`P0.03`)
- `DISP_SCLK`: Pin 31 (`P0.31`)
- `DISP_MOSI`: Pin 29 (`P0.29`)
- `DISP_MISO`: Pin 38 (`P1.06`)
- `DISP_BACKLIGHT`: Pin 43 (`P1.11`)

#### GPS / GNSS (Quectel L76K)
- `PIN_GPS_RX`: Pin 40 (`P1.08`)
- `PIN_GPS_TX`: Pin 41 (`P1.09`)
- `GPS_EN`: Pin 34 (`P1.02`)
- `PIN_GPS_SWITCH`: Pin 33 (`P1.01`) - Physical GPS slide switch
- `PIN_GPS_PPS`: Pin 36 (`P1.04`)

#### Controls & Power
- `PIN_USER_BTN` (`PIN_BUTTON1`): Pin 42 (`P1.10`)
- `PIN_BUTTON2` (Rotary knob push): Pin 11 (`P0.11`)
- `BATTERY_PIN`: Pin 4 (`P0.04`) - Resistor divider (150K + 150K), 3.0V ADC ref
- `PIN_BUZZER`: Pin 6 (`P0.06`)

---

<a id="polski"></a>
## Polski

### Opis komponentów sprzętowych
Elecrow ThinkNode M1 to kompaktowe urządzenie komunikacji radiowej dalekiego zasięgu MeshCore oparte na układzie nRF52840.

- **Wyświetlacz E-Ink**: Matryca 1.54 cala (200x200 px), czarno-biała o zerowym poborze prądu przy statycznym obrazie.
- **Podświetlenie (Frontlight)**: Dioda doświetlająca na pinie D43 sterowana włącznikiem pokrętła (`PIN_BUTTON2`).
- **GPS**: Moduł L76K z fizycznym suwakiem włączania na pinie D33.
