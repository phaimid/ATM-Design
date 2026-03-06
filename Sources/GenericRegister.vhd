library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GenericRegister is
    Generic ( SIZE : integer :=4);
    Port ( Clk : in std_logic;
           En : in std_logic;
           Input : in std_logic_vector(SIZE-1 downto 0);
           Output : out std_logic_vector(SIZE-1 downto 0));
end GenericRegister;

architecture Behavioral of GenericRegister is

signal Aux : std_logic_vector(SIZE-1 downto 0) := (others => '0');

begin

process(Clk)
begin
    if rising_edge(Clk) then
        if En = '1' then
            Aux <= Input;
        else
            Aux <= Aux;
        end if;
    end if;
end process;

Output <= Aux;

end Behavioral;
