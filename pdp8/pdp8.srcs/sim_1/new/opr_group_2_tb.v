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
    integer i = 0;

    reg [0:11] ac_reg, i_reg;
    reg l_reg;
    wire skip_flag;

    integer skip_flag_result = 0; 

    localparam period = 20;

    `include "do_skip.vh"

    assign skip_flag = do_skip(l_reg, ac_reg, i_reg);

    initial
    begin
        $display("---=== OR  GROUP ===---");

        // OR group - None of the predicates are true
        $display("test 1");
        ac_reg = 1;
        l_reg = 0;
        i_reg = 12'b11110xxx0000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result << 1 | skip_flag;
        end
        if (skip_flag_result)
            $display("test failed: skip_flag expected to be 0 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // OR group - Only SNL is true
        $display("test 2");
        ac_reg = 1;
        l_reg = 1;
        i_reg = 12'b11110xxx0000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b10101010)
            $display("test failed: expected 10101010 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // OR group - Only SZA is true
        $display("test 3");
        ac_reg = 0;
        l_reg = 0;
        i_reg = 12'b11110xxx0000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b11001100)
            $display("test failed: expected 11001100 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // OR group - Only SMA is true
        $display("test 4");
        ac_reg = -1;
        l_reg = 0;
        i_reg = 12'b11110xxx0000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b11110000)
            $display("test failed: expected 11110000 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // OR group - SMA and SNL are true
        $display("test 5");
        ac_reg = -1;
        l_reg = 1;
        i_reg = 12'b11110xxx0000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b11111010)
            $display("test failed: expected 11111010 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // OR group - SZA and SNL are true
        $display("test 6");
        ac_reg = 0;
        l_reg = 1;
        i_reg = 12'b11110xxx0000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b11101110)
            $display("test failed: expected 11101110 but got %08b", skip_flag_result);
        else
            $display("ok.");

        $display("---=== AND GROUP ===---");

        skip_flag_result = 0;

        // AND group - All of the predicates are true
        $display("test 1");
        ac_reg = 1;
        l_reg = 0;
        i_reg = 12'b11110xxx1000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b11111111)
            $display("test failed: expected 11111111 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // AND group - SZL is not true
        $display("test 2");
        ac_reg = 1;
        l_reg = 1;
        i_reg = 12'b11110xxx1000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b01010101)
            $display("test failed: expected 01010101 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // AND group - SNA is not true
        $display("test 3");
        ac_reg = 0;
        l_reg = 0;
        i_reg = 12'b11110xxx1000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b00110011)
            $display("test failed: expected 00110011 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // AND group - SPA is not true
        $display("test 4");
        ac_reg = -1;
        l_reg = 0;
        i_reg = 12'b11110xxx1000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b00001111)
            $display("test failed: expected 00001111 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // AND group - SPA and SZL are not true
        $display("test 5");
        ac_reg = -1;
        l_reg = 1;
        i_reg = 12'b11110xxx1000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b00000101)
            $display("test failed: expected 00000101 but got %08b", skip_flag_result);
        else
            $display("ok.");

        skip_flag_result = 0;

        // AND group - SNA and SZL are not true
        $display("test 6");
        ac_reg = 0;
        l_reg = 1;
        i_reg = 12'b11110xxx1000;
        for (i=0; i<8; i=i+1) begin
            i_reg = {i_reg[0:4], i, i_reg[8:11]};
            #period;
            skip_flag_result = skip_flag_result | skip_flag << i;
        end
        if (skip_flag_result != 8'b00010001)
            $display("test failed: expected 00010001 but got %08b", skip_flag_result);
        else
            $display("ok.");

    end

endmodule
