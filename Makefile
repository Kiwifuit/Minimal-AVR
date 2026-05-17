MCU = atmega328p
F_CPU = 1x000000UL

SRCDIR = src
BUILDDIR = build
SOURCES = main.c
PROJECT = blinky

AVRDUDE = avrdude
OBJCOPY = avr-objcopy
CC = avr-gcc
CFLAGS = -Wall -Werror -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os

ALL_OBJS = $(patsubst %.c, $(BUILDDIR)/%.o, $(SOURCES))

.PHONY: read_fuse flash clean

flash: $(BUILDDIR)/$(PROJECT).hex
	avrdude -c usbasp -p $(MCU) -U flash:w:$^:i

read_fuse:
	avrdude -c usbasp -p $(MCU) -U lfuse:r:-:h -U hfuse:r:-:h -U efuse:r:-:h

clean:
	rm -fr $(BUILDDIR)/

builddir:
	mkdir -p $(BUILDDIR)

$(BUILDDIR)/$(PROJECT).hex: $(BUILDDIR)/$(PROJECT).elf
	$(OBJCOPY) -j .text -j .data -O ihex --change-address=0x0000 $^ $@

$(BUILDDIR)/$(PROJECT).elf: $(ALL_OBJS)
	$(CC) $(CFLAGS) -o $@ $<

$(BUILDDIR)/%.o: $(SRCDIR)/%.c | builddir
	$(CC) $(CFLAGS) -c -o $@ $^
