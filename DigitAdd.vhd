library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DigitAdd is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0));
end DigitAdd;

architecture Behavioral of DigitAdd is

signal aux : std_logic_vector(0 downto 0) := "0";

begin

aux(0) <= Cin;

process(A,B,aux)
begin
    if unsigned(A)+unsigned(B)+unsigned(aux) > 9 then
        Cout <= '1';
        Sum <= std_logic_vector(unsigned(A)+unsigned(B)+unsigned(aux)-10);
    else
        Cout <= '0';
        Sum <= std_logic_vector(unsigned(A)+unsigned(B)+unsigned(aux));
    end if;
end process;

end Behavioral;
