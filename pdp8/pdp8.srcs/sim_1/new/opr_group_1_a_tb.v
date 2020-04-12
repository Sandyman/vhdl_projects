`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2020 19:44:06
// Design Name: 
// Module Name: opr_group_1_a_tb
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


module opr_group_1_a_tb;

    reg [0:11] ac_reg = 1, i_reg;
    reg l_reg = 1;
    wire [0:11] ac1;
    wire l1;
    
    localparam period = 200;

    opr_group_1_a opr_impl_1_a(
        .l_reg(l_reg), 
        .ac_reg(ac_reg), 
        .i_reg(i_reg), 
        .ac_out(ac1), 
        .l_out(l1));

    initial
    begin
        i_reg = 12'b111010000000;
        #period;
        if (ac1 != 0)
            $display("test failed: expected ac1 to be 0.");

        i_reg = 12'b111000000000;
        #period;
        if (ac1 != 1)
            $display("test failed: expected ac1 to be 1.");

        i_reg = 12'b111001000000;
        #period;
        if (l1 != 0)
            $display("test failed: expected l1 to be 0.");

        i_reg = 12'b111000000000;
        #period;
        if (l1 != 1)
            $display("test failed: expected l1 to be 1.");
                        
    end    

endmodule
