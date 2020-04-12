`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2020 16:31:14
// Design Name: 
// Module Name: opr_group_1_d
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


module opr_group_1_d(
    input [0:11] ac_reg,
    input l_reg,
    input [0:11] i_reg,
    output reg [0:11] ac_out,
    output reg l_out
    );

always @ (ac_reg, l_reg, i_reg[8:10])
begin
    case (i_reg[8:10])
        3'b100:  {l_out, ac_out} = {ac_reg[11], l_reg, ac_reg[0:10]}; // RAR
        3'b010:  {l_out, ac_out} = {ac_reg[0:11], l_reg}; // RAL
        3'b101:  {l_out, ac_out} = {ac_reg[10:11], l_reg, ac_reg[0:9]}; // RTR
        3'b011:  {l_out, ac_out} = {ac_reg[1:11], l_reg, ac_reg[0]}; // RTL
        default: {l_out, ac_out} = {l_reg, ac_reg}; // NOP
    endcase
end

endmodule
