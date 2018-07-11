# verilog-6502-ledblink

This is a template/sample project for using a 6502 core in a SoC type fashion.

## Features

* [Arlet Ottens' 6502 core](https://github.com/Arlet/verilog-6502)
* 1K block ram (increase as needed)
* 1K block rom, loaded with a hex file (increase as needed)
* A rough gpio module that's designed to blink a number of leds
* A simple 6502 assembly project that blinks some leds (requires acme and some unix tools)

## Requirements

* Altera/Intel Quartus (for the included projects anyway)
* FPGA hardware and/or verilog simulator
* ACME cross-assembler
* Unix environment for building the hex file (WSL works fine on Windows)

## Getting started

* Clone the repository with submodules:
  `git clone --recursive https://github.com/desaster/verilog-6502-ledblink`
* Compile the assembly project in `asm/`, resulting in a `ledblink.hex` file
* *either*: Open the project for your board in Quartus from
  `target/<board>/project/verilog-6502-ledblink.qpf`
* *or*: Create your own project, placing your project in `target/<board>/project/` and board specific verilog files in `target/<board>/hdl/`

## When building

* Make sure RAM and ROM are inferred properly into blockram/rom.
