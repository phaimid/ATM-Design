----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/23/2025 08:06:07 PM
-- Design Name: 
-- Module Name: MUXEight - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUXEight is
    Port ( Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Input1 : in STD_LOGIC_VECTOR (15 downto 0);
           Input2 : in STD_LOGIC_VECTOR (15 downto 0);
           Input3 : in STD_LOGIC_VECTOR (15 downto 0);
           Input4 : in STD_LOGIC_VECTOR (15 downto 0);
           Input5 : in STD_LOGIC_VECTOR (15 downto 0);
           Input6 : in STD_LOGIC_VECTOR (15 downto 0);
           Input7 : in STD_LOGIC_VECTOR (15 downto 0);
           Input8 : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out STD_LOGIC_VECTOR (15 downto 0));
end MUXEight;

architecture Behavioral of MUXEight is

component MUXFour is
    Port ( Sel : in STD_LOGIC_VECTOR (1 downto 0);
           Input1 : in STD_LOGIC_VECTOR (15 downto 0);
           Input2 : in STD_LOGIC_VECTOR (15 downto 0);
           Input3 : in STD_LOGIC_VECTOR (15 downto 0);
           Input4 : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal Output1 : std_logic_vector(15 downto 0) := x"0000";
signal Output2 : std_logic_vector(15 downto 0) := x"0000";

begin
M1: MUXFour port map (Sel => Sel(1 downto 0), Input1 => Input1, Input2 => Input2, Input3 => Input3, Input4 => Input4, Output => Output1);
M2: MUXFour port map (Sel => Sel(1 downto 0), Input1 => Input5, Input2 => Input6, Input3 => Input7, Input4 => Input8, Output => Output2);

process(Sel,Output1,Output2)
begin
    if Sel(2) = '0' then
        Output <= Output1;
    else
        Output <= Output2;
    end if;
end process;

end Behavioral;
