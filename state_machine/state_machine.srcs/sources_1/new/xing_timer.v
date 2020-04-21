`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2020 16:45:24
// Design Name: 
// Module Name: xing_timer
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


module xing_timer(
    input reset,
    input clock,
    input set,
    output flash,
    output grace_expired,
    output green_expired,
    output flash_expired);

reg [7:0] counter = 0;

assign grace_expired = (counter >= 2 * `TICKS_PER_SECOND);
assign green_expired = (counter >= 15 * `TICKS_PER_SECOND);
assign flash_expired = (counter >= 10 * `TICKS_PER_SECOND);

always @ (posedge clock)
begin
    if (reset || set)
        counter <= 0;
    else if (~ (grace_expired && green_expired && flash_expired))
        counter <= counter + 1;
end

//
// The next part creates a 1Hz "flash" clock. We force the
// flash output to go HIGH when SET is set.
//
reg [2:0] flash_clk = 3'd0;

always @ (posedge clock)
begin
    if (reset)
        flash_clk <= 3'd0;
    else if (set)
        flash_clk = 3'd4;
    else
        flash_clk <= flash_clk + 1;
end

assign flash = flash_clk[2];

endmodule
