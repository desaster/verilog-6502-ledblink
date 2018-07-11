/* Copyright (c) 2018 Upi Tamminen, All rights reserved.
 * See the LICENSE file for more information */

module top(
    input           CLOCK_48,
    input   [3:0]   KEY,
    output          DS_EN1,
    output          DS_EN2,
    output          DS_EN3,
    output          DS_EN4,
    output          DS_A,
    output          DS_B,
    output          DS_C,
    output          DS_D,
    output          DS_E,
    output          DS_F,
    output          DS_G,
    output          DS_DP
);

wire clk;

reg enable = 1;
reg reset = 1;
reg [7:0] reset_count = 0;
wire [7:0] gpio1;

assign DS_EN1 = 1'b1;
assign DS_EN2 = 1'b1;
assign DS_EN3 = 1'b1;
assign DS_EN4 = 1'b1;
assign DS_A = 1'b1;
assign DS_B = 1'b1;
assign DS_C = ~gpio1[2];
assign DS_D = ~gpio1[3];
assign DS_E = 1'b1;
assign DS_F = 1'b1;
assign DS_G = ~gpio1[1];
assign DS_DP = ~gpio1[0];

clk_div #(.SYS_CLK(48000000), .CLK_OUT(1000000)) clk_div_1(
    .clk (CLOCK_48),
    .clk_out (clk),
    .enable (enable)
);

cpu_core #(.ROM_FILE("../../../asm/ledblink.hex")) cpu_core(
    .clk (clk),
    .reset (reset),
    .gpio1 (gpio1)
);

always @(posedge clk) begin
    if (reset == 1) begin
        reset_count = reset_count + 1'b1;
        if (reset_count == 8'hff) begin
            reset <= 0;
        end
    end
end

always @(negedge KEY[0]) begin
    enable = ~enable;
end

endmodule
