library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VectorAdd is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Sum : out STD_LOGIC_VECTOR (15 downto 0));
end VectorAdd;

architecture Behavioral of VectorAdd is

component DigitAdd is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal aux : std_logic_vector (4 downto 0) := "00000";

begin

VEC: for i in 0 to 3 generate
    C: DigitAdd port map (A => A(4*(i+1)-1 downto 4*i), B => B(4*(i+1)-1 downto 4*i), Cin => aux(i), Cout => aux(i+1), Sum => Sum(4*(i+1)-1 downto 4*i));
end generate VEC;

end Behavioral;
