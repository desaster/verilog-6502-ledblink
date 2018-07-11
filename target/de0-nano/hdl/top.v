/* Copyright (c) 2018 Upi Tamminen, All rights reserved.
 * See the LICENSE file for more information */

module top(
    input           CLOCK_50,
    output  [7:0]   LED,
    input   [1:0]   KEY,
    input   [3:0]   SW
);

wire clk;
reg enable = 1;
reg reset = 1;
reg [7:0] reset_count = 0;
reg [2:0] KEYr;

clk_div #(.SYS_CLK(50000000), .CLK_OUT(1000000)) clk_div_1(
    .clk (CLOCK_50),
    .clk_out (clk),
    .enable (enable)
);

cpu_core #(.ROM_FILE("../../../asm/ledblink.hex")) cpu_core(
    .clk (clk),
    .reset (reset),
    .gpio1 (LED)
);

always @(posedge clk) begin
    if (reset == 1) begin
        reset_count = reset_count + 1'b1;
        if (reset_count == 8'hff) begin
            reset <= 0;
        end
    end

    KEYr <= { KEYr[1:0], KEY[0] };
    if (KEYr[2:1] == 2'b01) enable = ~enable;
end

endmodule
