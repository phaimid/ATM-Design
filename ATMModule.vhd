library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ATMModule is
    Port ( OP_Mode : in STD_LOGIC_VECTOR (2 downto 0);
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           BTN_INC : in STD_LOGIC;
           BTN_NXT : in STD_LOGIC;
           BTN_STATE : in STD_LOGIC;
           dataOut : out STD_LOGIC_VECTOR (7 downto 0);
           AN : out STD_LOGIC_VECTOR(7 downto 0);
           CurState : out STD_LOGIC_VECTOR(3 downto 0));
end ATMModule;

architecture Behavioral of ATMModule is

component MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC);
end component;

component ControlUnit is
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
end component;

component ExecutionUnit is
    Port (Clk : in STD_LOGIC;
          BTN_INC : in STD_LOGIC;
          BTN_NXT : in STD_LOGIC;
          dataOut : out STD_LOGIC_VECTOR (7 downto 0);
          AN : out STD_LOGIC_VECTOR(7 downto 0);
          IsonDatabase : out STD_LOGIC;
          CheckPIN : out STD_LOGIC;
          IsEnough : out STD_LOGIC;
          En2 : in STD_LOGIC;
          En4 : in STD_LOGIC;
          EnR1 : in STD_LOGIC;
          EnR2 : in STD_LOGIC;
          EnR3 : in STD_LOGIC;
          EnR4 : in STD_LOGIC;
          EnR5 : in STD_LOGIC;
          EnR6 : in STD_LOGIC;
          EnR7 : in STD_LOGIC;
          DMUXSel : in STD_LOGIC_VECTOR(2 downto 0);
          PINSel : in STD_LOGIC;
          MoneySel : in STD_LOGIC_VECTOR(1 downto 0);
          OutSel : in STD_LOGIC_VECTOR(2 downto 0);
          OutRst : in STD_LOGIC;
          WEPIN : in STD_LOGIC;
          WEMoney : in STD_LOGIC);
end component;

--The stabilized signals for the buttons
signal Stt : std_logic := '0';
signal Inc : std_logic := '0';
signal Nxt : std_logic := '0';

--The control signals used between the main units
signal IsonDatabase : STD_LOGIC := '0';
signal CheckPIN : STD_LOGIC := '0';
signal IsEnough : STD_LOGIC := '0';

signal En2 : STD_LOGIC := '0';
signal En4 : STD_LOGIC := '0';
signal EnR1 : STD_LOGIC := '0';
signal EnR2 : STD_LOGIC := '0';
signal EnR3 : STD_LOGIC := '0';
signal EnR4 : STD_LOGIC := '0';
signal EnR5 : STD_LOGIC := '0';
signal EnR6 : STD_LOGIC := '0';
signal EnR7 : STD_LOGIC := '0';

signal DMUXSel : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal PINSel : STD_LOGIC := '0';
signal MoneySel : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal OutSel : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal OutRst : STD_LOGIC := '0';

signal WEPIN : STD_LOGIC := '0';
signal WEMoney : STD_LOGIC := '0';

begin
--The three MPGs
MPGStt : MPG port map (btn => BTN_STATE, clk => Clk, en => Stt);
MPGInc : MPG port map (btn => BTN_INC, clk => Clk, en => Inc);
MPGNxt : MPG port map (btn => BTN_NXT, clk => Clk, en => Nxt);

--The Control Unit
CU : ControlUnit port map (OP_Mode => OP_Mode, 
                           Rst => Rst, 
                           Clk => Clk, 
                           BTN_STATE => Stt, 
                           CurState => CurState, 
                           IsonDatabase => IsonDatabase, 
                           CheckPIN => CheckPIN,
                           IsEnough => IsEnough,
                           En2 => En2,
                           En4 => En4,
                           EnR1 => EnR1,
                           EnR2 => EnR2,
                           EnR3 => EnR3,
                           EnR4 => EnR4,
                           EnR5 => EnR5,
                           EnR6 => EnR6,
                           EnR7 => EnR7,
                           DMUXSel => DMUXSel,
                           PINSel => PINSel,
                           MoneySel => MoneySel,
                           OutSel => OutSel,
                           OutRst => OutRst,
                           WEPIN => WEPIN,
                           WEMoney => WeMoney);
                           
--The Execution unit
EU : ExecutionUnit port map (Clk => Clk,
                             BTN_INC => Inc,
                             BTN_NXT => Nxt,
                             dataOut => dataOut,
                             AN => AN,
                             IsonDatabase => IsonDatabase,
                             CheckPIN => CheckPIN,
                             IsEnough => IsEnough,
                             En2 => En2,
                             En4 => En4,
                             EnR1 => EnR1,
                             EnR2 => EnR2,
                             EnR3 => EnR3,
                             EnR4 => EnR4,
                             EnR5 => EnR5,
                             EnR6 => EnR6,
                             EnR7 => EnR7,
                             DMUXSel => DMUXSel,
                             PINSel => PINSel,
                             MoneySel => MoneySel,
                             OutSel => OutSel,
                             OutRst => OutRst,
                             WEPIN => WEPIN,
                             WEMoney => WEMoney); 
                             
                             
end Behavioral;
