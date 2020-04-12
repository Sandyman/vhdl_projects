`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2020 16:25:52
// Design Name: 
// Module Name: opr_group_1_b
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


module opr_group_1_b(
    input [0:11] ac_reg,
    input l_reg,
    input [0:11] i_reg,
    output reg [0:11] ac_out,
    output reg l_out
    );

always @ (ac_reg, l_reg, i_reg[6:7])
begin
    ac_out = i_reg[6] ? ~ ac_reg : ac_reg; // CMA
    l_out = i_reg[7] ? ~ l_reg : l_reg; // CML
end

endmodule
