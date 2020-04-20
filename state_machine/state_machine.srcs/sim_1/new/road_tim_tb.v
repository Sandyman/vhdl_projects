`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2020 17:33:34
// Design Name: 
// Module Name: road_tim_tb
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


module road_tim_tb;

reg reset = 1;
reg clock = 0;
reg set = 0;
wire grace_expired;
wire green_expired;
wire yellow_expired;

road_timer uut(
    reset,
    clock,
    set,
    grace_expired,
    green_expired,
    yellow_expired);

// 50 MHz clock
always #10 clock <= ~clock;

initial
begin
    #12 reset <= 0;

    // Single SET pulse
    #98 set <= 1;
    #20 set <= 0;

    #300;
    if (grace_expired != 1'b0) $finish;
    #20;
    if (grace_expired != 1'b1) $finish;

    #460
    if (yellow_expired != 1'b0) $finish;
    #20
    if (yellow_expired != 1'b1) $finish;
    
    #2380;
    if (green_expired != 1'b0) $finish;
    #20;
    if (green_expired != 1'b1) $finish;

    $display("ok.");
end

endmodule
