`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2020 20:29:51
// Design Name: 
// Module Name: fsm
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


module fsm(
    input clock,
    input reset
    );

localparam S0=0, S1=1, S2=2, S3=3;

reg[1:0] current_state;
reg[1:0] next_state;

always @ (posedge clock)
begin
    if (reset)
        current_state <= S0;
    else
        current_state <= next_state;
end

always @ (*)
begin
    next_state = current_state;
    case (current_state)
        S0: next_state = S2;
        S1: next_state = S3;
        S2: next_state = S1;
        S3: next_state = S2;
    endcase
end

endmodule
