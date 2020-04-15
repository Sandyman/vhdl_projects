`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2020 15:29:14
// Design Name: 
// Module Name: opr_group_2_tb
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



module opr_group_2_tb;

reg [0:11] ac_reg, i_reg;
reg l_reg;
wire skip_flag;

localparam period = 20;

`include "do_skip.vh"

assign skip_flag = do_skip(l_reg, ac_reg, i_reg);

integer skip_flag_result, i;


task simulate;

input integer num;
input [0:7] expected_result;

begin
    $display("test %2d", num);
    skip_flag_result = 0;
    for (i=0; i<8; i=i+1) begin
        i_reg = {i_reg[0:4], i, i_reg[8:11]};
        #period;
        skip_flag_result = skip_flag_result | skip_flag << i;
    end
    if (skip_flag_result != expected_result)
    begin
        $display("test failed: skip_flag expected to be %08b but got %08b.", expected_result, skip_flag_result);
        $display("stop.");
        $finish;
    end
    else
        $display("ok.");
end

endtask

initial
begin
    $display("---=== OR  GROUP ===---");

    // OR group - None of the predicates are true
    ac_reg = 1;
    l_reg = 0;
    i_reg = 12'b11110xxx0000;
    simulate(1, 8'b0);

    // OR group - Only SNL is true
    ac_reg = 1;
    l_reg = 1;
    i_reg = 12'b11110xxx0000;
    simulate(2, 8'b10101010);

    // OR group - Only SZA is true
    ac_reg = 0;
    l_reg = 0;
    i_reg = 12'b11110xxx0000;
    simulate(3, 8'b11001100);

    // OR group - Only SMA is true
    ac_reg = -1;
    l_reg = 0;
    i_reg = 12'b11110xxx0000;
    simulate(4, 8'b11110000);

    // OR group - SMA and SNL are true
    ac_reg = -1;
    l_reg = 1;
    i_reg = 12'b11110xxx0000;
    simulate(5, 8'b11111010);

    // OR group - SZA and SNL are true
    ac_reg = 0;
    l_reg = 1;
    i_reg = 12'b11110xxx0000;
    simulate(6, 8'b11101110);

    $display("---=== AND GROUP ===---");

    // AND group - All of the predicates are true
    ac_reg = 1;
    l_reg = 0;
    i_reg = 12'b11110xxx1000;
    simulate(1, 8'b11111111);

    // AND group - SZL is not true
    ac_reg = 1;
    l_reg = 1;
    i_reg = 12'b11110xxx1000;
    simulate(2, 8'b01010101);

    // AND group - SNA is not true
    ac_reg = 0;
    l_reg = 0;
    i_reg = 12'b11110xxx1000;
    simulate(3, 8'b00110011);

    // AND group - SPA is not true
    ac_reg = -1;
    l_reg = 0;
    i_reg = 12'b11110xxx1000;
    simulate(4, 8'b00001111);

    // AND group - SPA and SZL are not true
    ac_reg = -1;
    l_reg = 1;
    i_reg = 12'b11110xxx1000;
    simulate(5, 8'b00000101);

    // AND group - SNA and SZL are not true
    ac_reg = 0;
    l_reg = 1;
    i_reg = 12'b11110xxx1000;
    simulate(6, 8'b00010001);

end

endmodule
