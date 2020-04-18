`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2020 17:36:23
// Design Name: 
// Module Name: pwm_tb
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


module pwm_tb;

reg reset = 1;
reg clock = 0;
wire[7:0] pwm_out;

wire on = pwm_out >= 220;

reg led = 1;

wire pwm_led = led & on;

pwm uut(
    .reset(reset),
    .clock(clock),
    .pwm(pwm_out));

initial #17 reset <= 0;

always #5 clock <= ~ clock;

always #20000000 led <= ~ led;

endmodule
