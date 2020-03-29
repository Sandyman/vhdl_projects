`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2020 13:01:30
// Design Name: 
// Module Name: fig5_62
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


module fig5_62(
    input btn_0,
    input btn_1,
    output reg led
    );

wire [1:0] index;

assign index = {btn_0, btn_1};

always @ (index)
begin
  case (index)
    2'b00   : led = 1;
    2'b01   : led = 0;
    2'b10   : led = 1;
    2'b11   : led = 1;
    default : led = 0;
  endcase
end

endmodule
