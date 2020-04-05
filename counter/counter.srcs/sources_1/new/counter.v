`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2020 17:24:19
// Design Name: 
// Module Name: counter
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

/*
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity chip is 
port (
    clock : in std_logic;
    reset : in std_logic;
    counter : out std_logic_vector(7 downto 0)
    );
end entity chip;

architecture rtl of chip is

signal counter_i : unsigned(7 downto 0);

begin 
    process(clock)
    begin
        if rising_edge(clock) then
            counter_i <= counter_i + 1;
            if reset = '1' then
                   counter_i <= (others => '0');
            end if; -- reset
        end if; -- clock
    end process;

    counter <= std_logic_vector(counter_i);

end rtl;

*/

module counter(
    input clock,
    input reset,
    output [7:0] count
    );

reg [7:0] count_v;

always @ (posedge clock)
begin
    if (reset)
        count_v = 0;
    else
        count_v = count + 1;
       
end

assign count = count_v;

endmodule
