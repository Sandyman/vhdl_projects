`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2020 16:41:47
// Design Name: 
// Module Name: clock_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "timer_values.vh"


module clock_divider(
    input reset,
    input clk,
    output clock);

reg [22:0] counter = 23'd0;
reg clock_out;

assign clock = clock_out;

always @ (posedge clk)
begin
    if (reset)
        counter <= 23'd0;
    else if (counter >= `CLOCK_MAX_COUNT)
    begin
        counter <= 23'd0;
        clock_out <= ~clock_out;
    end
    else
        counter <= counter + 1;
end

endmodule
