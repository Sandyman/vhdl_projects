`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2020 16:48:12
// Design Name: 
// Module Name: road_fsm
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


module road_fsm(
    input reset,
    input clock,
    input btn,
    input done,
    input grace_expired,
    input green_expired,
    input yellow_expired,
    output reg set,
    output reg go,
    output red,
    output green);

localparam GN=0, YL=1, RD=2, GC=3;

reg [3:0] current;
reg [3:0] next;

assign red = current[RD] | current[GC] | current[YL];
assign green = current[GN] | current[YL];

always @ (posedge clock)
begin
    if (reset)
    begin
        current <= 4'b0;
        current[GC] <= 1'b1;
    end
    else
        current <= next;        
end

always @ (*)
begin
    next = 4'b0000;
    set = 1'b0;
    go = 1'b0;
    case (1'b1)
    current[GN]: begin
        if (green_expired && btn) begin
            next[YL] = 1'b1;
            set = 1;
        end
        else
            next[GN] = 1'b1;
    end
    current[YL]: begin
        if (yellow_expired) begin
            next[RD] = 1'b1;
            set = 1;
            go = 1;
        end
        else
            next[YL] = 1'b1;
    end
    current[RD]: begin
        if (done) begin
            set = 1;
            next[GC] = 1'b1;
        end
        else
            next[RD] = 1'b1;
    end
    current [GC]: begin
        if (grace_expired) begin
            set = 1;
            next[GN] = 1'b1;
        end
        else
            next[GC] = 1'b1;
    end
    endcase
end

endmodule
