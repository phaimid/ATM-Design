library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SevenSegDisplay is
    Port ( dataIn : in STD_LOGIC_VECTOR (3 downto 0);
           dataOut : out STD_LOGIC_VECTOR (7 downto 0));
end SevenSegDisplay;

architecture Behavioral of SevenSegDisplay is

begin

with dataIn select
    dataOut <= "11000000" when "0000", --0  xC0
               "11111001" when "0001", --1  xF9
               "10100100" when "0010", --2  xA4   
               "10110000" when "0011", --3  xB0
               "10011001" when "0100", --4  x99
               "10010010" when "0101", --5  x92
               "10000010" when "0110", --6  x82
               "11111000" when "0111", --7  xF8
               "10000000" when "1000", --8  x80
               "10010000" when "1001", --9  x90
               "10001000" when "1010", --A  x88
               "10000000" when "1011", --B  x80
               "11000110" when "1100", --C  xC6
               "11000000" when "1101", --D  xC0
               "10000110" when "1110", --E  x86
               "10001110" when "1111", --F  x8E
               x"00" when others;

end Behavioral;
