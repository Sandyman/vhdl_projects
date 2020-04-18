`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2020 16:45:39
// Design Name: 
// Module Name: pwd
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


module pwm(
    input reset,
    input clock,
    output [7:0] pwm
    );

reg [9:0] counter = 0;
reg clock_50khz = 0;

always @ (posedge clock)
begin
    if (reset)
        counter <= 10'd0;
    else if (counter >= 10'd1000) begin
        counter <= 10'd0;
        clock_50khz <= ~ clock_50khz;
    end
    else
        counter <= counter + 1;
end

// This register goes full circle (0->249->0) in 5 ms (200Hz)
reg [7:0] pwm_reg = 0;
assign pwm = pwm_reg;

always @ (posedge clock_50khz)
begin
    if (reset)
        pwm_reg <= 8'd0;
    else if (pwm_reg >= 8'd249)
        pwm_reg <= 8'd0;
    else
        pwm_reg <= pwm_reg + 1;
end

endmodule
