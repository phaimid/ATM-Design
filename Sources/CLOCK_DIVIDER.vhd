library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CLOCK_DIVIDER is
    Port (  CLK: in STD_LOGIC;
            RST: in STD_LOGIC;
            CLK_OUT: out STD_LOGIC
         );
end CLOCK_DIVIDER;

architecture Behavioral of CLOCK_DIVIDER is
signal COUNT: INTEGER := 1;
signal TEMP_CLK: STD_LOGIC := '0';
begin

--This clock divider transforms 100MHz into 187Hz. For each rising edge, count is updated
--So, an output clock cycle is given after 267_380*2 clock cycles
process(CLK, RST)
begin
    if RST = '1' then
        TEMP_CLK <= '0';
        COUNT <= 1;
    elsif RISING_EDGE(CLK) then 
        COUNT <= COUNT + 1;
        if COUNT = 267_380 then             --267_380 aprox. 187Hz
            TEMP_CLK <= NOT TEMP_CLK;
            COUNT <= 1;
        end if;
    end if;
end process;
CLK_OUT <= TEMP_CLK;
end Behavioral;