# Copyright (c) 2018 Upi Tamminen, All rights reserved.
# See the LICENSE file for more information

# Acme doesn't create a memory dump, so we are crafting it by hand here.
# Feel free to use any tools you're comfortable with for this. 
#
# Rough idea is:
#  * create an empty file of the appropriate size (1K)
#  * write our compiled binary file to the beginning of the file
#  * add the reset vector near the end of the file, 6502 expects it at $FFFC
#    (the value depends on where your code ends up in the address space, which
#    depends on the size of the rom image)
#  * convert the binary file hex values for use with $readmemh()

TARGET = ledblink.hex
SHELL=/bin/bash

$(TARGET): ledblink.asm

.PRECIOUS: %.bin %.dump

%.bin: %.asm
	acme --cpu 6502 --format plain --outfile $@ $<

%.dump: %.bin
	dd if=/dev/zero of=$@ count=1 bs=1K status=none
	dd conv=notrunc if=$< of=$@ status=none
	printf '\x00\xfc' | dd conv=notrunc seek=1020 bs=1 of=$@ status=none

%.hex: %.dump
	hexdump -v -e '/1 "%02X "' < $< > $@

.PHONY: clean
clean:
	rm -f *.bin *.hex *.dump
