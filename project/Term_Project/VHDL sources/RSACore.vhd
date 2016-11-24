library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RSACore is
    Port ( Clk : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           InitRsa : in STD_LOGIC;
           StartRsa : in STD_LOGIC;
           DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           CoreFinished : out STD_LOGIC);
end RSACore;



architecture Behavioral of RSACore is

COMPONENT TopLevelStateMachine  
            Port ( 
            InitRsa             : in STD_LOGIC;
            StartRsa            : in STD_LOGIC;
            Clk                 : in STD_LOGIC;
            Resetn              : in STD_LOGIC;
            ExpDone             : in STD_LOGIC;
            dataShiftedOut      : in STD_LOGIC;

            DataReceived        : out STD_LOGIC;
            EnableDataReg       : out STD_LOGIC;
            EnableCtrlReg       : out STD_LOGIC;
            CoreFinishedn       : out STD_LOGIC
          );
end COMPONENT;
    
    
COMPONENT Sipo  
            Port (    
            DataIn              : in STD_LOGIC_VECTOR (31 downto 0);
            CLK                 : in STD_LOGIC;
            Enable              : in STD_LOGIC;
            Resetn              : in STD_LOGIC;
            ParallelOut         : out STD_LOGIC_VECTOR (127 downto 0);
            DaisyChainOut : out STD_LOGIC_VECTOR ( 31 downto 0 )         
            );
end COMPONENT;
        


COMPONENT ModularExponentiation
            Port ( 
            M           : in  STD_LOGIC_VECTOR (127 downto 0);
            E           : in  STD_LOGIC_VECTOR (127 downto 0);
            N           : in  STD_LOGIC_VECTOR (127 downto 0);
            DataInReady : in  STD_LOGIC;
            Clk         : in  STD_LOGIC;
            Resetn      : in  STD_LOGIC;
            ExpDone     : out STD_LOGIC;
            C           : out STD_LOGIC_VECTOR (127 downto 0)
            );
end COMPONENT;

COMPONENT shiftout 
            PORT (
           clk, rst_n, startShiftOut    : in  STD_LOGIC;
           M                            : in  STD_LOGIC_VECTOR (127 downto 0);
           DataShiftComplete            : out STD_LOGIC;
           DataOut                      : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

signal M_data               : STD_LOGIC_VECTOR ( 127 downto 0 );
signal N_parameter          : STD_LOGIC_VECTOR ( 127 downto 0 );
signal E_parameter          : STD_LOGIC_VECTOR ( 127 downto 0 ); 
signal N_register_chainOut  : STD_LOGIC_VECTOR (  31 downto 0 );
signal ModExp_Result        : STD_LOGIC_VECTOR ( 127 downto 0 );               

signal EnableDataReg        : STD_LOGIC;
signal EnableCTRLReg        : STD_LOGIC;
signal ExpDone              : STD_LOGIC;
signal dataShiftedOut       : STD_LOGIC := '0';
signal dataReceived         : STD_LOGIC;

begin

FSM : TopLevelStateMachine      
                PORT MAP (   
                InitRsa => InitRsa,             StartRsa => StartRsa, 
                Clk => Clk,                     
                Resetn => Resetn,               CoreFinishedn => CoreFinished,
                ExpDone => ExpDone,             dataShiftedOut => dataShiftedOut,
                EnableDataReg => EnableDataReg, EnableCTRLReg => EnableCtrlReg,
                DataReceived => dataReceived  );

M_data_register : Sipo          
                PORT MAP (  
                DataIn => DataIn,               CLK => Clk,
                Enable => enableDataReg,        Resetn => Resetn,
                ParallelOut => M_data );
            
N_parameter_register : Sipo     
                PORT MAP (  
                DataIn => DataIn,          CLK => Clk,
                Enable => enableCTRLReg,        Resetn => Resetn,
                ParallelOut => N_parameter,     DaisyChainOut => N_register_chainOut );
            
E_parameter_register : Sipo     
                PORT MAP (  
                DataIn => N_register_chainOut,  CLK => Clk,
                Enable => enableCTRLREG,        Resetn => Resetn,
                ParallelOut => E_parameter );                                         
           
 
ModularExp  :  ModularExponentiation
                PORT MAP (  
                M => M_data,                     E => E_parameter,
                N => N_parameter,               DataInReady => dataReceived,
                Clk => Clk,                     Resetn => Resetn,
                ExpDone => ExpDone,             C => ModExp_Result );
                                                                  
outputShifter : shiftout        
                PORT MAP (  
                Clk => Clk,                     Rst_n => Resetn,
                StartShiftOut => ExpDone,       M => ModExp_Result,
                DataOut =>  DataOut );

    
 
    
    
    
end Behavioral;
