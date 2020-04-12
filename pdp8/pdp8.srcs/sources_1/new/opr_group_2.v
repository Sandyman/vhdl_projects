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


module opr_group_2(
    input l_reg,
    input [0:11] ac_reg,
    input [0:11] i_reg,
    output do_skip
    );

assign ac_eqz = ~|ac_reg;

assign ac_neg = i_reg[5] && ac_reg[0];
assign ac_clr = i_reg[6] && ac_eqz;
assign l_set = i_reg[7] && l_reg;

assign do_skip = i_reg[8] ? ~ac_neg && ~ac_clr && ~l_set  // SPA, SNA, SZL
                          :  ac_neg ||  ac_clr ||  l_set; // SMA, SZA, SNL

endmodule
