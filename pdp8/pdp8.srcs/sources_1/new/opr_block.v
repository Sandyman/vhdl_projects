`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2020 21:09:54
// Design Name: 
// Module Name: opr_block
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

module cpu(
//    input [0:11] ac_reg,
//    input l_reg,
    input [0:11] i_reg,
    input clock,
    input reset,
    input en_load_opr1,
    output [0:11] ac_out,
    output l_out,
    output do_skip
    );

reg [0:11] ac_reg = 0;
reg l_reg = 0;

wire [0:11] ac1, ac2, ac3, ac4;
wire l1, l2, l3, l4;

opr_group_1_a opr_impl_1_a(
    .l_reg(l_reg), 
    .ac_reg(ac_reg), 
    .i_reg(i_reg), 
    .ac_out(ac1), 
    .l_out(l1));

opr_group_1_b opr_impl_1_b(
    .l_reg(l1), 
    .ac_reg(ac1), 
    .i_reg(i_reg), 
    .ac_out(ac2), 
    .l_out(l2));

opr_group_1_c opr_impl_1_c(
    .l_reg(l2), 
    .ac_reg(ac2), 
    .i_reg(i_reg), 
    .ac_out(ac3), 
    .l_out(l3));

opr_group_1_d opr_impl_1_d(
    .l_reg(l3), 
    .ac_reg(ac3), 
    .i_reg(i_reg), 
    .ac_out(ac4), 
    .l_out(l4));

assign ac_out = ac_reg;
assign l_out = l_reg;

always @ (posedge clock)
begin
    if (reset) ac_reg <= 0;
    else if (en_load_opr1) ac_reg <= ac4;
end

endmodule
