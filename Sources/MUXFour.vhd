library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUXFour is
    Port ( Sel : in STD_LOGIC_VECTOR (1 downto 0);
           Input1 : in STD_LOGIC_VECTOR (15 downto 0);
           Input2 : in STD_LOGIC_VECTOR (15 downto 0);
           Input3 : in STD_LOGIC_VECTOR (15 downto 0);
           Input4 : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out STD_LOGIC_VECTOR (15 downto 0));
end MUXFour;

architecture Behavioral of MUXFour is

component MUXTwo is
    Port ( Sel : in STD_LOGIC;
           Input1 : in STD_LOGIC_VECTOR (15 downto 0);
           Input2 : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal Output1 : std_logic_vector(15 downto 0) := x"0000";
signal Output2 : std_logic_vector(15 downto 0) := x"0000";

begin

M1 : MUXTWO port map (Sel => Sel(0), Input1 => Input1, Input2 => Input2, Output => Output1);
M2 : MUXTWO port map (Sel => Sel(0), Input1 => Input3, Input2 => Input4, Output => Output2);

process(Sel,Output1,Output2)
begin
    if Sel(1) = '0' then
        Output <= Output1;
    else
        Output <= Output2;
    end if;
end process;

end Behavioral;
