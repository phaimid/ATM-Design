library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VectorBigger is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Outp : out STD_LOGIC);
end VectorBigger;

architecture Behavioral of VectorBigger is

begin

Outp <= '1' when to_integer(unsigned(A)) >= to_integer(unsigned(B)) else '0';

end Behavioral;
