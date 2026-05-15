# AVR Minimal Blink Program

The code in this repository demonstrates the use of a
USBasp programmer to program a Atmega328p microcontroller.

The program toggles `PB13`, typically set to the onboard
LED on the Arduino Uno, at a frequency of 1 Hz.

This repository depends on the existence of the AVR
toolchain, along with its standard library and GNU Make
to automate the flash process.

## Getting Started

```sh
# 16 MHz external clock, preserve EEPROM, no bootloader
# Refer to https://www.engbedded.com/fusecalc/ if you
# wish to use different values
$ avrdude -c usbasp -p atmega328p -U lfuse:r:0xff:m -U hfuse:r:0xd9:m -U efuse:r:0xfd:m

# Chip erase the flash. EEPROM will also be erased
# if the EESAVE bit of the hfuse is left unprogrammed
$ avrdude -c usbasp -p atmega328p -e

$ make flash # or simply make
```
