library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DigitDif is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Dif : out STD_LOGIC_VECTOR (3 downto 0));
end DigitDif;

architecture Behavioral of DigitDif is

signal aux : std_logic_vector(0 downto 0) := "0";

begin

aux(0) <= Cin;

process(A, B, aux)
begin 
    if unsigned(A) >= unsigned(B) + unsigned(aux) then
        Dif <= std_logic_vector(unsigned(A) - unsigned(B) - unsigned(aux));
        Cout <= '0';
    else
        Dif <= std_logic_vector(10 + unsigned(A) - unsigned(B) - unsigned (aux));
        Cout <= '1';
    end if;
end process;

end Behavioral;
