`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2020 16:43:35
// Design Name: 
// Module Name: road_timer
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


module road_timer(
    input reset,
    input clock,
    input set,
    output grace_expired,
    output green_expired,
    output yellow_expired);

reg [7:0] counter = 0;

assign grace_expired = (counter >= 2 * `TICKS_PER_SECOND);
assign green_expired = (counter >= 20 * `TICKS_PER_SECOND);
assign yellow_expired = (counter >= 5 * `TICKS_PER_SECOND);

always @ (posedge clock)
begin
    if (reset || set)
        counter <= 0;
    else if (~ (grace_expired && green_expired && yellow_expired))
        counter <= counter + 1;
end
endmodule
