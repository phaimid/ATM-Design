library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SevenSegVector is
    Generic ( SIZE : integer := 4);
    Port ( Input : in STD_LOGIC_VECTOR(4*SIZE-1 downto 0);
           Output : out STD_LOGIC_VECTOR(8*SIZE-1 downto 0));
end SevenSegVector;

architecture Behavioral of SevenSegVector is

component SevenSegDisplay is
    Port ( dataIn : in STD_LOGIC_VECTOR (3 downto 0);
           dataOut : out STD_LOGIC_VECTOR (7 downto 0));
end component;

begin

DisplayVector : for i in 0 to SIZE-1 generate
    C: SevenSegDisplay port map ( dataIn => Input(4*(i+1)-1 downto 4*i), dataOut => Output(8*(i+1)-1 downto 8*i));
end generate;

end Behavioral;
