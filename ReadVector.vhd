library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ReadVector is
    Generic ( SIZE : integer := 4);
    Port (En : in STD_LOGIC;
          BTN_INC : in STD_LOGIC;
          BTN_NXT : in STD_LOGIC;
          Output : out STD_LOGIC_VECTOR(4*SIZE-1 downto 0));
end ReadVector;

architecture Behavioral of ReadVector is

component ZeroNineCounter is
    Port ( En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           dataOut : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal EnV: std_logic_vector(SIZE-1 downto 0) := (0 => '1', others => '0');
signal RstV: std_logic_vector(SIZE-1 downto 0) := (others => '0');
signal i: integer := 0;

begin

CounterVector: for i in 0 to SIZE-1 generate
    C: ZeroNineCounter port map (En => EnV(i), Clk => BTN_INC, Rst => RstV(i), dataOut => Output(4*(i+1)-1 downto 4*i));
end generate CounterVector;

--En process for the RSTs
process(En)
begin
    if En = '0' then
        RstV <= (others => '1');
    else
        RstV <= (others => '0');
    end if;
end process;

--Main process
process(En, BTN_NXT, BTN_INC)
begin
    if En = '0' then
        i <= 0;
        EnV <= (0 => '1', others => '0');
    elsif En = '1' then
        if rising_edge(BTN_NXT) then
            EnV(i) <= '0';
            if i < SIZE-1 then
                EnV(i+1) <= '1';
                i <= i+1;
            else 
                EnV(0) <= '1';
                i <= 0;
            end if;
        end if;
    end if;
end process;

end Behavioral;
