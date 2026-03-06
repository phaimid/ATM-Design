library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VectorComparator is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Outp : out STD_LOGIC);
end VectorComparator;

architecture Behavioral of VectorComparator is

begin

Outp <= '1' when A = B else '0';

end Behavioral;
