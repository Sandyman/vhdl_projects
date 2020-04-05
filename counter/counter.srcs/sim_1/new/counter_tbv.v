//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2020 15:50:09
// Design Name: 
// Module Name: counter_tbv
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

module tbv;

    reg clock = 0;
    reg reset = 1;
    wire [7:0] count;
    wire done;

    initial #17 reset <= 0;

    counter uut(.clock(clock), .reset(reset), .count(count));

    always #5  clock <= ~clock;

    assign done = count == 8'hff;

endmodule
