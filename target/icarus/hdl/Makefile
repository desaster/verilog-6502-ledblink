#verilog -s cpu_core_tb cpu_core.v clk_div.v gpio.v ram.v rom.v ../external/arlet-verilog-6502/cpu.v ../external/arlet-verilog-6502/ALU.v
TARGET=cpu_core_tb
HDL=../../../hdl
CPU=../../../external/arlet-verilog-6502

IVERILOG=iverilog -s cpu_core_tb
VVP=vvp -n
GTKWAVE=gtkwave

SRC=$(wildcard $(HDL)/*.v) $(wildcard $(CPU)/*.v)

ASM=$(shell find ../../.. -type d -name 'asm')
#BLINKASM=$(shell find ../../.. -type f -name 'ledblink.asm')
#BLINKHEX=$(shell find ../../.. -type f -name 'ledblink.hex')
BLINKHEX=$(ASM)/ledblink.hex

all:	$(TARGET).vcd

wave:	$(TARGET).vcd
	$(GTKWAVE) $^ &

clean:	
	rm -f $(TARGET).vvp $(TARGET).vcd
	make -C $(ASM) clean

$(TARGET).vcd:	$(TARGET).vvp $(BLINKHEX)
	$(VVP) $^

$(TARGET).vvp:	$(SRC)
	$(IVERILOG) -DFINISHTIME=8000 -D LEDBLINKHEX=\"$(BLINKHEX)\" -o $@ $^

$(BLINKHEX):	$(ASM)
	make -C $(ASM) -f Makefile.$(shell uname) SIM=1
