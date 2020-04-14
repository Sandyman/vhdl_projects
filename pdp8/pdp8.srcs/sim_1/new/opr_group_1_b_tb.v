`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2020 20:05:33
// Design Name: 
// Module Name: opr_group_1_b_tb
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


module opr_group_1_b_tb;

    reg [0:11] ac_reg = 1, i_reg;
    reg l_reg = 1;
    wire [0:11] ac;
    wire l;

    localparam period = 20;

    opr_group_1_b opr_impl_1_a(
        .l_reg(l_reg),
        .ac_reg(ac_reg),
        .i_reg(i_reg),
        .ac_out(ac),
        .l_out(l));

    initial
    begin
        i_reg = 12'b111000100000;
        #period;
        if (ac != ~ac_reg || l != l_reg)
            $display("test failed: CMA / ~CML");

        i_reg = 12'b111000010000;
        #period;
        if (l != ~l_reg || ac != ac_reg)
            $display("test failed: ~CMA / CML");

        i_reg = 12'b111000000000;
        #period;
        if (ac != ac_reg || l != l_reg)
            $display("test failed: ~CMA / ~CML");

        i_reg = 12'b111000110000;
        #period;
        if (ac != ~ac_reg || l != ~l_reg)
            $display("test failed: CMA / CML");

        $display("opr_group_1_b_tb finished.");

    end

endmodule
