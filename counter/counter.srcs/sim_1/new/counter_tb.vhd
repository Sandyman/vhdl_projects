----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2020 16:26:34
-- Design Name: 
-- Module Name: counter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity tb;

--
-- module tb;
--
-- reg clock = '0';
-- reg reset = '1';
-- reg count [7:0];
-- reg done = false;
--
-- always @ ()
-- begin
--     #5  clock <= !clock;
--     #17 reset <= '0';
--     work.counter uut(.clock(clock), .reset(reset), .count(count));
--     done <= count == 8'hff;
-- end
-- endmodule

architecture rtl of tb is

    signal clock : std_logic := '0';
    signal reset : std_logic := '1';
    signal count : std_logic_vector(7 downto 0);
    signal done  : boolean   := false;

begin

    clock <= not clock after 5 ns;
    reset <= '0' after 17 ns;

    uut : entity work.counter(rtl)
        port map(
            clock => clock,
            reset => reset,
            count => count
        );

    done <= count = X"ff";

end architecture rtl;
