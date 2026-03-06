library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ZeroNineCounter is
    Port ( En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           dataOut : out STD_LOGIC_VECTOR (3 downto 0));
end ZeroNineCounter;

architecture Behavioral of ZeroNineCounter is

signal A: std_logic_vector (3 downto 0) := "0000";

begin

process(Clk, Rst, En)
begin
    if Rst = '1' then
        A <= "0000";
    elsif En = '1' then
        if rising_edge(Clk) then 
            if unsigned(A) < 9 then
                A <= std_logic_vector(unsigned(A)+1);
            else
                A <= "0000";
            end if;
        end if;
    end if;
end process;

dataOut <= A;

end Behavioral;
