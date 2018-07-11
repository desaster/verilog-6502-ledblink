/* Copyright (c) 2018 Upi Tamminen, All rights reserved.
 * See the LICENSE file for more information */

module clk_div(
    input           clk,
    input           enable,
    output  reg     clk_out
);

// counter size calculation according to input and output frequencies
parameter SYS_CLK = 50000000;   // 50 MHz system clock
parameter CLK_OUT = 1000000;    // 1 MHz clock output
parameter COUNTER_MAX = SYS_CLK / (2 * CLK_OUT); // max-counter size

reg [4:0] counter;

initial begin
    counter = 0;
    clk_out = 0;
end

always @(posedge clk && enable) begin
    if (counter == COUNTER_MAX - 1) begin
        counter <= 0;
        clk_out <= ~clk_out;
    end
    else begin
        counter <= counter + 1'd1;
    end
end

endmodule

//
// Testbench
//

module clk_div_tb;

reg clk_50;
wire clk_1;

clk_div DUT(
    .clk (clk_50),
    .enable (1'b1),
    .clk_out (clk_1)
);

initial begin
    clk_50 = 1'b0;
end

always #1
    clk_50 = !clk_50;

endmodule
