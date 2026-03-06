library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DMUXEight is
    Port ( Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Input : in STD_LOGIC_VECTOR (15 downto 0);
           Output1 : out STD_LOGIC_VECTOR (15 downto 0);
           Output2 : out STD_LOGIC_VECTOR (15 downto 0);
           Output3 : out STD_LOGIC_VECTOR (15 downto 0);
           Output4 : out STD_LOGIC_VECTOR (15 downto 0);
           Output5 : out STD_LOGIC_VECTOR (15 downto 0);
           Output6 : out STD_LOGIC_VECTOR (15 downto 0);
           Output7 : out STD_LOGIC_VECTOR (15 downto 0);
           Output8 : out STD_LOGIC_VECTOR (15 downto 0));
end DMUXEight;

architecture Behavioral of DMUXEight is

begin

Output1 <= Input when Sel = "000" else x"0000";
Output2 <= Input when Sel = "001" else x"0000";
Output3 <= Input when Sel = "010" else x"0000";
Output4 <= Input when Sel = "011" else x"0000";
Output5 <= Input when Sel = "100" else x"0000";
Output6 <= Input when Sel = "101" else x"0000";
Output7 <= Input when Sel = "110" else x"0000";
Output8 <= Input when Sel = "111" else x"0000";

end Behavioral;
