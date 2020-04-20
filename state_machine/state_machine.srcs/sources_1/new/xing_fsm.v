`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2020 16:49:03
// Design Name: 
// Module Name: xing_fsm
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


module xing_fsm(
    input reset,
    input clock,
    input button,
    input go,
    input flash,
    input grace_expired,
    input green_expired,
    input flash_expired,
    output reg set,    
    output btn,
    output reg done,
    output red,
    output green);

localparam RD=0, // Red 
           GR=1, // Grace period before Green
           GN=2, // Green
           FL=3, // Flashing Red
           GC=4; // Grace period before Red

reg [4:0] current;
reg [4:0] next;

reg button_pressed = 0;
reg clr_button = 0;

assign green = current[GN];
assign red = current[RD] || current[GR] || current[GC] || current[FL] && flash;

assign btn = button_pressed;

always @ (posedge clock)
begin
    if (reset || clr_button) begin
        button_pressed <= 0;
    end
    else
        button_pressed <= button_pressed | button;
end

always @ (posedge clock)
begin
    if (reset)
    begin
        current <= 5'b00000;
        current[GC] <= 1'b1;
    end
    else
        current <= next;        
end

always @ (*)
begin
    next = 5'b00000;
    set = 1'b0;
    done = 1'b0;
    clr_button = 1'b0;
    case (1'b1)
    current[RD]: begin
        if (go) begin
            clr_button = 1;
            set = 1;
            next[GR] = 1'b1;
        end
        else
            next[RD] = 1'b1;
    end
    current[GR]: begin
        if (grace_expired) begin
            set = 1;
            next[GN] = 1'b1;
        end
        else
            next[GR] = 1'b1;
    end
    current[GN]: begin
        if (green_expired) begin
            set = 1;
            next[FL] = 1'b1;
        end
        else
            next[GN] = 1'b1;
    end
    current[FL]: begin
        if (flash_expired) begin
            set = 1;
            next[GC] = 1'b1;
        end
        else
            next[FL] = 1'b1;
    end
    current[GC]: begin
        if (grace_expired) begin
            set = 1;
            done = 1;
            next[RD] = 1'b1;
        end
        else
            next[GC] = 1'b1;
    end
    endcase
end

endmodule
