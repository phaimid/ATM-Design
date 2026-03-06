library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GENERIC_RAM is
    generic( N_ADD: integer :=5;
             N_DATA: integer :=16);
    Port ( Clk : in STD_LOGIC;
           CS : in STD_LOGIC;
           WE : in STD_LOGIC;
           Add : in std_logic_vector((N_ADD-1) downto 0);
           DataIn : in std_logic_vector((N_DATA-1) downto 0);
           DataOut : out std_logic_vector((N_DATA-1) downto 0));
end GENERIC_RAM;

architecture Behavioral of GENERIC_RAM is
type RAM_MEM is array ((2**N_ADD-1) downto 0) of std_logic_vector((N_DATA-1) downto 0);
signal memory : RAM_MEM:= (others=>(others=>'0'));

begin

process(Clk)
begin
    if rising_edge(Clk) then
        if CS = '1' then
            if WE = '1' then
                memory(to_integer(unsigned(Add))) <= DataIn;
            end if;
            DataOut <= memory(to_integer(unsigned(Add)));
        else
            DataOut <= (others => '0');
        end if;
    end if;
end process;

end Behavioral;
