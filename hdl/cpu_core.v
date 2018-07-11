/* Copyright (c) 2018 Upi Tamminen, All rights reserved.
 * See the LICENSE file for more information */

/*
memory map:

RAM     0x0000  0
        0x03ff  1023

GPIO    0x0400  1024    (big area, gpio gets duplicated)
        0x07ff  2047

unused  0x0800  2048
        0xfbff  64511

ROM     0xfc00  64512
        0xffff  65535
*/

module cpu_core #(parameter ROM_FILE = "foo.hex") (
    input           clk,
    input           reset,
    output  [7:0]   gpio1
);

wire [15:0] addr;
wire [7:0] cpu_do;
wire [7:0] cpu_di;
wire we;

//
// RAM
//
wire [7:0] ram_do;
wire cs_ram = (addr[15:10]   == 6'b000000) ? 1'b1 : 1'b0; // 0000-03ff
reg cs_ram_prev = 1'b0;
always @(posedge clk) cs_ram_prev <= cs_ram;
ram #(
    .ADDR_WIDTH(10),
    .DEPTH(1024))
ram(
    .clk (clk),
    .cs (cs_ram),
    .we (we && cs_ram),
    .addr (addr[9:0]),
    .data_in (cpu_do),
    .data_out (ram_do)
);

//
// ROM
//
wire [7:0] rom_do;
wire cs_rom = (addr[15:10]   == 6'b111111) ? 1'b1 : 1'b0; // fc00-ffff
reg cs_rom_prev = 1'b0;
always @(posedge clk) cs_rom_prev <= cs_rom;
rom #(
    .ADDR_WIDTH(10),
    .DEPTH(1024),
    .ROM_FILE(ROM_FILE))
rom(
    .clk (clk),
    .cs (cs_rom),
    .addr (addr[9:0]),
    .data_in (cpu_do),
    .data_out (rom_do)
);

//
// GPIO (leds)
//
wire cs_gpio1 = (addr[15:10] == 6'b000001) ? 1'b1 : 1'b0; // 0400-07ff
reg cs_gpio1_prev = 1'b0;
always @(posedge clk) cs_gpio1_prev <= cs_gpio1;
gpio gpio1_device(
    .clk (clk),
    .reset (reset),
    .cs (cs_gpio1),
    .data_in (cpu_do),
    .data_out (gpio1)
);

//
// CPU
//
cpu cpu(
    .clk (clk),
    .reset (reset),
    .AB (addr),
    .DI (cpu_di),
    .DO (cpu_do),
    .WE (we),
    .IRQ (1'b0),
    .NMI (1'b0),
    .RDY (1'b1)
);

/* use cs values from previous clk for delayed read */
assign cpu_di =
    cs_ram_prev ? ram_do :
    cs_rom_prev ? rom_do :
    cs_gpio1_prev ? gpio1 :
    8'h00;

endmodule

//
// Testbench
//

`timescale 1ns/10ps

module cpu_core_tb;

reg clk = 0;
reg reset = 1;
wire [7:0] fakeled;

cpu_core #(.ROM_FILE("../../../../../asm/ledblink.hex")) DUT(
    .clk (clk),
    .reset (reset),
    .gpio1 (fakeled)
);

initial begin
    #50 reset <= 0;
    #85 $display("addr %x: %s",
        DUT.addr,
        (DUT.addr == 16'hfc00) ? "OK" : "FAIL");
    #10000000 $stop;
end

always #10 clk <= ~clk;

endmodule
