----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2016 18:12:25
-- Design Name: 
-- Module Name: RSACore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


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

    COMPONENT TopLevelStateMachine  Port ( 
                                            InitRsa : in STD_LOGIC;
                                            StartRsa : in STD_LOGIC;
                                            Clk : in STD_LOGIC;
                                            ClkCounterIn : in STD_LOGIC_VECTOR ( 3 downto 0);
                                            Resetn : in STD_LOGIC;
                                            ExpDone: in STD_LOGIC;
                                            dataShiftedOut : in STD_LOGIC;
           
                                            DataReceived : out STD_LOGIC;
                                            EnableDataReg : out STD_LOGIC;
                                            EnableCtrlReg : out STD_LOGIC;
                                            CoreFinishedn : out STD_LOGIC;
                                            CounterEnable : out STD_LOGIC
                                          );
    end COMPONENT;
    
    
    COMPONENT negEdgeSipo Port (    DataIn : in STD_LOGIC_VECTOR (31 downto 0);
                                        CLK : in STD_LOGIC;
                                        Enable : in STD_LOGIC;
                                        Resetn : in STD_LOGIC;
                                        ParallelOut : out STD_LOGIC_VECTOR (127 downto 0)
                                    );
     end COMPONENT;
        
     COMPONENT NegEdgeCounter Port (    Enable : in STD_LOGIC;
                                        Clk : in STD_LOGIC;
                                        Resetn : in STD_LOGIC;
                                        CountVal : out STD_LOGIC_VECTOR (3 downto 0));
     end COMPONENT;


    signal DataRegisterContent  : STD_LOGIC_VECTOR(127 downto 0 );
    signal CTRLRegisterContent  : STD_LOGIC_VECTOR(127 downto 0 ); 
    signal EnableDataReg        : STD_LOGIC;
    signal EnableCTRLReg        : STD_LOGIC;
    signal ClkCounterIn         : STD_LOGIC_VECTOR(3 downto 0);
    signal ExpDone              : STD_LOGIC := '0';
    signal dataShiftedOut       : STD_LOGIC := '0';
    signal CounterEnable        : STD_LOGIC;

begin

    FSM: TopLevelStateMachine PORT MAP (        InitRsa => InitRsa, 
                                                StartRsa => StartRsa, 
                                                Clk => Clk,
                                                ClkCounterIn => ClkCounterIn,
                                                Resetn => Resetn,
                                                CoreFinishedn => CoreFinished,
                                                ExpDone => ExpDone,
                                                dataShiftedOut => dataShiftedOut,
                                                
                                                EnableDataReg => EnableDataReg,
                                                EnableCTRLReg => EnableCtrlReg,
                                                CounterEnable => CounterEnable
                                                
                                        );
    DataRegister: negEdgeSipo PORT MAP (    DataIn => DataIn,
                                            CLK => Clk,
                                            Enable => enableDataReg,
                                            Resetn => Resetn,
                                            ParallelOut => DataRegisterContent
                                        );
                                        
     CTRLRegister:negEdgeSipo PORT MAP (    DataIn => DataIn,
                                            CLK => Clk,
                                            Enable => enableCTRLReg,
                                            Resetn => Resetn,
                                            ParallelOut => CTRLRegisterContent
                                       );
                                       
    DataInCounter: NegEdgeCounter PORT MAP ( Enable => CounterEnable, 
                                             Clk => Clk,
                                             Resetn => Resetn,
                                             CountVal => ClkCounterIn
                                            );
                                               
    
    
end Behavioral;
