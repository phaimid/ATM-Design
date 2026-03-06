library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUXTwo is
    Port ( Sel : in STD_LOGIC;
           Input1 : in STD_LOGIC_VECTOR (15 downto 0);
           Input2 : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out STD_LOGIC_VECTOR (15 downto 0));
end MUXTwo;

architecture Behavioral of MUXTwo is

begin

process(Sel,Input1,Input2)
begin
    if Sel = '0' then
        Output <= Input1;
    else
        Output <= Input2;
    end if;
end process;

end Behavioral;
