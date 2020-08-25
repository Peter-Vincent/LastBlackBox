#!/bin/bash
set -eu

# Create output directory
mkdir -p bin
mkdir -p bin/interim

# Compile
avr-gcc -mmcu=atmega328p -Wall -Os -DF_CPU=16000000 read.c -o bin/interim/read.out

# Link
avr-ld -o bin/interim/read.elf bin/interim/read.out

# Something?
avr-objcopy --output-target=ihex bin/interim/read.elf bin/read.hex

# Report binary size
avr-size --format=avr --mcu=atmega328p bin/interim/read.elf

# Program the board
avrdude -v -p ATmega328p -c arduino -P /dev/ttyUSB0 -b 115200 -D -U flash:w:bin/read.hex

#FIN