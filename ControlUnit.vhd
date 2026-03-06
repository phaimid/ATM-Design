library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is
    Port ( OP_Mode : in STD_LOGIC_VECTOR (2 downto 0);
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           BTN_STATE : in STD_LOGIC;
           CurState : out STD_LOGIC_VECTOR(3 downto 0);
           IsonDatabase : in STD_LOGIC;
           CheckPIN : in STD_LOGIC;
           IsEnough : in STD_LOGIC;
           En2 : out STD_LOGIC;
           En4 : out STD_LOGIC;
           EnR1 : out STD_LOGIC;
           EnR2 : out STD_LOGIC;
           EnR3 : out STD_LOGIC;
           EnR4 : out STD_LOGIC;
           EnR5 : out STD_LOGIC;
           EnR6 : out STD_LOGIC;
           EnR7 : out STD_LOGIC;
           DMUXSel : out STD_LOGIC_VECTOR(2 downto 0);
           PINSel : out STD_LOGIC;
           MoneySel : out STD_LOGIC_VECTOR(1 downto 0);
           OutSel : out STD_LOGIC_VECTOR(2 downto 0);
           OutRst : out STD_LOGIC;
           WEPIN : out STD_LOGIC;
           WEMoney : out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is

--The signals which control the state of the module
type TIP_STARE is (A, B, C, D, E, F, G, H, I, J, K, L);
signal state : TIP_STARE := A;

begin

--The process which decides our state
process(Clk)
begin
    if rising_edge(Clk) then
        if Rst = '1' then
            state <= A;
        elsif BTN_STATE = '1' then
            case state is
                when A =>
                    if IsonDatabase = '1' then
                        state <= B;
                    else
                        state <= D;
                    end if;
                when B =>
                    state <= C;
                when C =>
                    state <= A;
                when D =>
                    if CheckPIN = '0' then
                        state <= E;
                    else
                        state <= F;
                    end if;
                when E =>
                    state <= A;
                when F =>
                    case OP_Mode is
                        when "000" =>
                            state <= L;
                        when "001" =>
                            state <= G;
                        when "010" =>
                            state <= J;
                        when "011" =>
                            state <= C;
                        when others =>
                            state <= I;
                    end case;
                when G =>
                    if IsEnough = '0' then
                        state <= E;
                    else
                        state <= H;
                    end if;
                when H =>
                    state <= I;
                when I =>
                    state <= A;
                when J =>
                    state <= K;
                when K =>
                    state <= I;
                when L =>
                    state <= A;
                when others =>
                    state <= E;   
            end case;
        end if;
     end if;
end process;

--The process which determines the values of all signals
process(state)
begin
    case state is
        when A =>
            En2 <= '1';
            En4 <= '0';
            EnR1 <= '1';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '1';
            EnR7 <= '1';
            DMUXSel <= "000";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "000";
            OutRst <= '0';
            WEPIN <= '0';
            WEMoney <= '0';
            CurState <= x"1";
            
        when B =>
            En2 <= '0';
            En4 <= '0';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "111";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "110";
            OutRst <= '0';
            WEPIN <= '0';
            WEMoney <= '0';
            CurState <= x"2";
            
        when C =>
            En2 <= '0';
            En4 <= '1';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '1';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "010";
            PINSel <= '1';
            MoneySel <= "00";
            OutSel <= "010";
            OutRst <= '0';
            WEPIN <= '1';
            WEMoney <= '0';
            CurState <= x"3";
            
        when D =>
            En2 <= '0';
            En4 <= '1';
            EnR1 <= '0';
            EnR2 <= '1';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "001";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "001";
            OutRst <= '0';
            WEPIN <= '0';
            WEMoney <= '0';
            CurState <= x"4";
            
        when E =>
            En2 <= '0';
            En4 <= '0';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "111";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "111";
            OutRst <= '0';
            WEPIN <= '0';
            WEMoney <= '0';
            CurState <= x"5";
            
        when F =>
            En2 <= '0';
            En4 <= '0';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "111";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "000";
            OutRst <= '1';
            WEPIN <= '0';
            WEMoney <= '0';
            CurState <= x"6";
            
        when G =>
            En2 <= '0';
            En4 <= '1';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '1';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "100";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "100";
            OutRst <= '0';
            WEPIN <= '0';
            WEMoney <= '0';
            CurState <= x"7";
            
        when H =>
            En2 <= '0';
            En4 <= '0';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "111";
            PINSel <= '0';
            MoneySel <= "10";
            OutSel <= "000";
            OutRst <= '1';
            WEPIN <= '0';
            WEMoney <= '1';
            CurState <= x"8";
            
        when I =>
            En2 <= '0';
            En4 <= '0';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '1';
            EnR7 <= '0';
            DMUXSel <= "111";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "101";
            OutRst <= '0';
            WEPIN <= '0';
            WEMoney <= '0';
            CurState <= x"9";
            
        when J =>
            En2 <= '0';
            En4 <= '1';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '1';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "011";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "011";
            OutRst <= '0';
            WEPIN <= '0';
            WEMoney <= '0';
            CurState <= x"A";
            
        when K =>
            En2 <= '0';
            En4 <= '0';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "111";
            PINSel <= '0';
            MoneySel <= "01";
            OutSel <= "000";
            OutRst <= '1';
            WEPIN <= '0';
            WEMoney <= '1';
            CurState <= x"B";
            
        when L =>   
            En2 <= '0';
            En4 <= '0';
            EnR1 <= '0';
            EnR2 <= '0';
            EnR3 <= '0';
            EnR4 <= '0';
            EnR5 <= '0';
            EnR6 <= '0';
            EnR7 <= '0';
            DMUXSel <= "111";
            PINSel <= '0';
            MoneySel <= "00";
            OutSel <= "000";
            OutRst <= '1';
            WEPIN <= '1';
            WEMoney <= '1';
            CurState <= x"C";
            
    end case;
end process;

end Behavioral;
