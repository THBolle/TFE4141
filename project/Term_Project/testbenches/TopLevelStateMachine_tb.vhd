----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2016 05:58:29 PM
-- Design Name: 
-- Module Name: TopLevelStateMachine_tb - Behavioral
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

entity TopLevelStateMachine_tb is
end TopLevelStateMachine_tb;




architecture Behavioral of TopLevelStateMachine_tb is

    COMPONENT TopLevelStateMachine  Port ( 
                                            InitRsa : in STD_LOGIC;
                                            StartRsa : in STD_LOGIC;
                                            Clk : in STD_LOGIC;
                                            ClkCounterIn : in STD_LOGIC_VECTOR ( 3 downto 0);
                                            Resetn : in STD_LOGIC;
                                            ExpDone: in STD_LOGIC;
                                            dataShiftedOut : in STD_LOGIC;
           
                                            DataReceived : out STD_LOGIC;
                                            DestRegister : out STD_LOGIC;
                                            EnableDataReg : out STD_LOGIC;
                                            EnableCtrlReg : out STD_LOGIC;
                                            CoreFinishedn : out STD_LOGIC;
                                            ClkCounterReset : out STD_LOGIC
                                          );
    end COMPONENT;


    --constants
    constant clk_period : time  := 20ns;
    
    -- input signals
     signal InitRsa        : STD_LOGIC                      := '0';
     signal StartRsa       : STD_LOGIC                      := '0';
     signal Clk            :  STD_LOGIC                     := '0';
     signal ClkCounterIn   : STD_LOGIC_VECTOR ( 3 downto 0) := x"0";
     signal Resetn         : STD_LOGIC                      := '0';
     signal ExpDone        : STD_LOGIC                      := '0';
     signal dataShiftedOut : STD_LOGIC                      := '0';
    
    -- output signals
    signal DataReceived     : STD_LOGIC;
    signal DestRegister     : STD_LOGIC;
    signal EnableDataReg    : STD_LOGIC;
    signal EnableCtrlReg    : STD_LOGIC;
    signal CoreFinishedn    : STD_LOGIC;
    signal ClkCounterReset  : STD_LOGIC;
    
    

begin
  UUT: TopLevelStateMachine PORT MAP (  InitRsa=>InitRsa,               
                                        StartRsa=>StartRsa,             
                                        Clk=> Clk,                      
                                        ClkCounterIn=>ClkCounterIn ,    
                                        Resetn=>Resetn,                 
                                        ExpDone => ExpDone,             
                                        dataShiftedOut=> dataShiftedOut,     
                                        DataReceived=> DataReceived,    
                                        DestRegister=> DestRegister,    
                                        EnableDataReg=>EnableDataReg ,  
                                        EnableCtrlReg=>EnableCtrlReg ,  
                                        CoreFinishedn=>CoreFinishedn,   
                                        ClkCounterReset=>ClkCounterReset
                           );


clk_process : process begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
     end process;
     
stim_process : process begin
        wait for 100ns;
        Resetn <= '1';
        wait for 100ns;
        initRsa <= '1';
        
        end process;


end Behavioral;
