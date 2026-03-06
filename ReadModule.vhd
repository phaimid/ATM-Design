library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ReadModule is
    Port (--Clk : in STD_LOGIC;
          En2 : in STD_LOGIC;
          En4 : in STD_LOGIC;
          BTN_INC : in STD_LOGIC;
          BTN_NXT : in STD_LOGIC;
          Output : out STD_LOGIC_VECTOR(15 downto 0));
end ReadModule;

architecture Behavioral of ReadModule is

component ReadVector is
    Generic ( SIZE : integer := 4);
    Port (En : in STD_LOGIC;
          BTN_INC : in STD_LOGIC;
          BTN_NXT : in STD_LOGIC;
          Output : out STD_LOGIC_VECTOR(4*SIZE-1 downto 0));
end component;

signal Output4 : std_logic_vector(15 downto 0) := x"0000";
signal Output2 : std_logic_vector(7 downto 0) := x"00";

begin

Read2 : ReadVector generic map (SIZE => 2) port map (En => En2, BTN_INC => BTN_INC, BTN_NXT => BTN_NXT, Output => Output2);
Read4 : ReadVector generic map (SIZE => 4) port map (En => En4, BTN_INC => BTN_INC, BTN_NXT => BTN_NXT, Output => Output4);

process(En2, En4, Output2, Output4)
begin
    if En2 = '1' then
        if En4 = '0' then
            Output <= x"00" & Output2;
        else
            Output <= x"0000";
        end if;
    else
        if En4 = '0' then
            Output <= x"0000";
        else
            Output <= Output4;
        end if;
    end if;
end process;

end Behavioral;
