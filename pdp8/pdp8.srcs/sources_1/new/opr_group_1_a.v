`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2020 16:21:58
// Design Name: 
// Module Name: opr_group_1_a
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


module opr_group_1_a(
    input [0:11] ac_reg,
    input l_reg,
    input [0:11] i_reg,
    output reg [0:11] ac_out,
    output reg l_out
    );

always @ (ac_reg, l_reg, i_reg[4:5])
begin
    ac_out = i_reg[4] ? 0 : ac_reg; // CLA
    l_out = i_reg[5] ? 0 : l_reg; // CLL
end

endmodule
