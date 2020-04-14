`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2020 16:15:52
// Design Name: 
// Module Name: opr_group_2
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


function do_skip;

input l_reg;
input [0:11] ac_reg;
input [0:11] i_reg;

begin
                       // SPA, SNA, SZL (AND group)
    do_skip = i_reg[8] ? ~(i_reg[5] && ac_reg[0]) && ~(i_reg[6] && ~|ac_reg) && ~(i_reg[7] && l_reg)
                       // SMA, SZA, SNL (OR group)
                       :   i_reg[5] && ac_reg[0]  ||   i_reg[6] && ~|ac_reg  ||   i_reg[7] && l_reg;
end

endfunction
