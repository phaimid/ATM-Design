library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ExecutionUnit is
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
end ExecutionUnit;

architecture Behavioral of ExecutionUnit is

component ReadModule is
    Port (En2 : in STD_LOGIC;
          En4 : in STD_LOGIC;
          BTN_INC : in STD_LOGIC;
          BTN_NXT : in STD_LOGIC;
          Output : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component GenericRegister is
    Generic ( SIZE : integer :=4);
    Port ( Clk : in std_logic;
           En : in std_logic;
           Input : in std_logic_vector(SIZE-1 downto 0);
           Output : out std_logic_vector(SIZE-1 downto 0));
end component;

component GENERIC_RAM is
    generic( N_ADD: integer :=5;
             N_DATA: integer :=16);
    Port ( Clk : in STD_LOGIC;
           CS : in STD_LOGIC;
           WE : in STD_LOGIC;
           Add : in std_logic_vector((N_ADD-1) downto 0);
           DataIn : in std_logic_vector((N_DATA-1) downto 0);
           DataOut : out std_logic_vector((N_DATA-1) downto 0));
end component;

component DMUXEight is
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
end component;

component MUXTwo is
    Port ( Sel : in STD_LOGIC;
           Input1 : in STD_LOGIC_VECTOR (15 downto 0);
           Input2 : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component MUXFour is
    Port ( Sel : in STD_LOGIC_VECTOR (1 downto 0);
           Input1 : in STD_LOGIC_VECTOR (15 downto 0);
           Input2 : in STD_LOGIC_VECTOR (15 downto 0);
           Input3 : in STD_LOGIC_VECTOR (15 downto 0);
           Input4 : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component MUXEight is
    Port ( Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Input1 : in STD_LOGIC_VECTOR (15 downto 0);
           Input2 : in STD_LOGIC_VECTOR (15 downto 0);
           Input3 : in STD_LOGIC_VECTOR (15 downto 0);
           Input4 : in STD_LOGIC_VECTOR (15 downto 0);
           Input5 : in STD_LOGIC_VECTOR (15 downto 0);
           Input6 : in STD_LOGIC_VECTOR (15 downto 0);
           Input7 : in STD_LOGIC_VECTOR (15 downto 0);
           Input8 : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component VectorAdd is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Sum : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component VectorDif is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Dif : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component SevenSegVector is
    Generic ( SIZE : integer := 4);
    Port ( Input : in STD_LOGIC_VECTOR(4*SIZE-1 downto 0);
           Output : out STD_LOGIC_VECTOR(8*SIZE-1 downto 0));
end component;

component CLOCK_DIVIDER is
    Port (  CLK: in STD_LOGIC;
            RST: in STD_LOGIC;
            CLK_OUT: out STD_LOGIC
         );
end component;

component SSD_MUX is
    Port ( CLK      : in STD_LOGIC;
           RST      : in STD_LOGIC;
           DIGITS   : in STD_LOGIC_VECTOR(31 downto 0);
           CATHODE  : out STD_LOGIC_VECTOR(7 downto 0);
           ANODE    : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component VectorComparator is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Outp : out STD_LOGIC);
end component;

component VectorBigger is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Outp : out STD_LOGIC);
end component;

--The input signal
signal Input : std_logic_vector(15 downto 0) := x"0000";

--The possible inputs which are going to be saved on registers plus the selection vector
signal AddressInput : std_logic_vector(15 downto 0) := x"0000";
signal PINInput : std_logic_vector(15 downto 0) := x"0000";
signal NewPINInput : std_logic_vector(15 downto 0) := x"0000";
signal MoneyAddInput : std_logic_vector(15 downto 0) := x"0000";
signal MoneySubInput : std_logic_vector(15 downto 0) := x"0000";

--The inputs saved using the registers
signal Address : std_logic_vector(15 downto 0) := x"0000";
signal PIN : std_logic_vector(15 downto 0) := x"0000";
signal NewPIN : std_logic_vector(15 downto 0) := x"0000";
signal MoneyAdd : std_logic_vector(15 downto 0) := x"0000";
signal MoneySub : std_logic_vector(15 downto 0) := x"0000";

--The signals used for the write input data for the RAMs - we control them using MUXs
signal PINWrite : std_logic_vector(15 downto 0) := x"0000";
signal MoneyWrite : std_logic_vector(15 downto 0) := x"0000";
signal MoneyAddWrite : std_logic_vector(15 downto 0) := x"0000";
signal MoneySubWrite : std_logic_vector(15 downto 0) := x"0000";

--The signals we get from the RAM databases
signal PINRead : std_logic_vector(15 downto 0) := x"0000";
signal PINRRead : std_logic_vector(15 downto 0) := x"0000";
signal MoneyRead : std_logic_vector (15 downto 0) := x"0000";
signal MoneyRRead : std_logic_vector (15 downto 0) := x"0000"; --We save the Money read on a register in order to be able to perform operations with that value without entering an infinite feedback loop

--The selected output signal which will be converted to the 7seg display
signal Output : std_logic_vector(15 downto 0) := x"0000";

--The converted output which will be passed onto the 7seg display
signal ConvertOutput : std_logic_vector(31 downto 0) := x"00000000";

--The divided clk signal used when displaying our output
signal NewClk : std_logic := '0';

--Dummy signal
signal garbage : std_logic_vector(15 downto 0) := x"0000";

begin

--The read module
Read : ReadModule port map (En2 => En2, En4 => En4, BTN_INC => BTN_INC, BTN_NXT => BTN_NXT, Output => Input);

--The DMUX which chooses what input we have
DMUX: DMUXEight port map (Sel => DMUXSel, Input => Input, Output1 => AddressInput, Output2 => PINInput, Output3 => NewPINInput, Output4 => MoneyAddInput, Output5 => MoneySubInput, Output6 => garbage, Output7 => garbage, Output8 => garbage);

--The registers with which we save the inputs
Reg1 : GenericRegister generic map (SIZE => 16) port map (Clk => Clk, En => EnR1, Input => AddressInput, Output => Address);
Reg2 : GenericRegister generic map (SIZE => 16) port map (Clk => Clk, En => EnR2, Input => PINInput, Output => PIN);
Reg3 : GenericRegister generic map (SIZE => 16) port map (Clk => Clk, En => EnR3, Input => NewPINInput, Output => NewPIN);
Reg4 : GenericRegister generic map (SIZE => 16) port map (Clk => Clk, En => EnR4, Input => MoneyAddInput, Output => MoneyAdd);
Reg5 : GenericRegister generic map (SIZE => 16) port map (Clk => Clk, En => EnR5, Input => MoneySubInput, Output => MoneySub);

--The register we use in order to save the value of MoneyRead and PINRead such that, while adding/subtracting a value from it, we don't enter a feedback loop (we write over the new value, then we add again, then we write again and so on so forth)
Reg6 : GenericRegister generic map (SIZE => 16) port map (Clk => Clk, En => EnR6, Input => MoneyRead, Output => MoneyRRead);
Reg7 : GenericRegister generic map (SIZE => 16) port map (Clk => Clk, En => EnR7, Input => PINRead, Output => PINRRead);

--The number adder and subtracter used in order to take out/add a sum of money to an account
Add : VectorAdd port map (A => MoneyRRead, B => MoneyAdd, Sum => MoneyAddWrite);
Sub : VectorDif port map (A => MoneyRRead, B => MoneySub, Dif => MoneySubWrite);

--The MUXs which choose what we write on the PIN RAM and Money RAM databases
PINMUX : MUXTwo port map (Sel => PINSel, Input1 => x"0000", Input2 => NewPIN, Output => PINWrite);
MoneyMUX : MUXFour port map (Sel => MoneySel, Input1 => x"0000", Input2 => MoneyAddWrite, Input3 => MoneySubWrite, Input4 => x"1000", Output => MoneyWrite);

--The two RAMs which form the databases
PINRAM : GENERIC_RAM generic map (N_ADD => 8, N_DATA => 16) port map (Clk => Clk, CS => '1', WE => WEPIN, Add => Address(7 downto 0), DataIn => PINWrite, DataOut => PINRead);
MoneyRAM : GENERIC_RAM generic map (N_ADD => 8, N_DATA => 16) port map (Clk => Clk, CS => '1', WE => WEMoney, Add => Address(7 downto 0), DataIn => MoneyWrite, DataOut => MoneyRead);

--The MUX which chooses what the output value will be
OutMUX : MUXEight port map (Sel => OutSel, Input1 => Address, Input2 => PIN, Input3 => NewPIN, Input4 => MoneyAdd, Input5 => MoneySub, Input6 => MoneyRRead, Input7 => x"0ADD", Input8 => x"0EAA", Output => Output);

--The component which converts the output for the 7seg display
Convert : SevenSegVector generic map (SIZE => 4) port map (Input => Output, Output => ConvertOutput);

--The clk divider 
Divide : CLOCK_DIVIDER port map (CLK => Clk, RST => '0', CLK_OUT => NewClk);

--The SSD_MUX used in order to print out the outputs
Print : SSD_MUX port map (CLK => NewClk, RST => OutRst, DIGITS => ConvertOutput, CATHODE => dataOut, ANODE => AN);

--The comparator which checks if PINRead is 0
Comp1 : VectorComparator port map (A => PINRRead, B => x"0000", Outp => IsonDatabase);

--The comparator which checks if the PIN from the input is correct
Comp2 : VectorComparator port map (A => PINRRead, B => PIN, Outp => CheckPIN);

--The component which checks if we have enough money to subtract
Comp3 : VectorBigger port map (A => MoneyRRead, B => MoneySub, Outp => IsEnough);

end Behavioral;
