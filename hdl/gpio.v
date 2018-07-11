/* Copyright (c) 2018 Upi Tamminen, All rights reserved.
 * See the LICENSE file for more information */

module gpio #(parameter NUM_PINS = 8) (
    input wire clk,
    input wire reset,
    input wire cs,
    input wire [NUM_PINS-1:0] data_in,
    output reg [NUM_PINS-1:0] data_out
);

always @(posedge clk) begin
    if (reset) begin
        data_out <= 8'h00;
    end
    else if (cs) begin
        data_out <= data_in;
    end
end

endmodule
