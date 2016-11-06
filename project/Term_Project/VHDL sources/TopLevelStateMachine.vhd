----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2016 05:11:55 PM
-- Design Name: 
-- Module Name: TopLevelStateMachine - Behavioral
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



entity TopLevelStateMachine is
    Port ( InitRsa : in STD_LOGIC;
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
           CounterEnable : out STD_LOGIC);
end TopLevelStateMachine;



architecture Behavioral of TopLevelStateMachine is

    type FSM_STATES is ( IDLE, RECEIVING_INIT, RECEIVING_DATA, PROCESSING, DONE  );
    
    signal state : FSM_STATES;



begin


    reset : process ( InitRsa, StartRsa, Clk, ClkCounterIn,Resetn ) begin
    
        if ( Resetn = '0' ) then 
            state <= IDLE;
        elsif rising_edge(Clk) then
         
            case state is
            
                when IDLE => 
                        if InitRsa = '1' then
                            state <= RECEIVING_INIT;
                        elsif ( StartRsa = '1') then
                            state <= RECEIVING_DATA;
                        end if;  
                
                when RECEIVING_INIT =>
                        if (ClkCounterIn = x"8") then
                            state <= IDLE;
                        end if;
                         
                when RECEIVING_DATA =>
                        if ( ClkCounterIn = x"8") then
                            state <= PROCESSING;
                        end if;
                        
                when PROCESSING =>
                        if ( ExpDone = '1') then
                            state <= DONE;
                        end if;
                when DONE =>
                        if (dataShiftedOut = '1') then
                            state <= IDLE;
                        end if;    
                 
              end case;  
              
                              
        end if;
    end process;
    
    -- Output logic
    DataReceived <= '1' when  ( State = PROCESSING) OR (State = DONE) 
               else '0';  
   

    
    EnableDataReg <= '1' when ( State = IDLE AND StartRsa = '1' ) OR ( State = RECEIVING_DATA)
                else '0';
                
    EnableCtrlReg <= '1' when ( State = IDLE AND InitRsa = '1' ) OR ( State = RECEIVING_INIT)
                else '0';
    
    CoreFinishedn <= '1' when ( State = IDLE OR State = DONE )
                else '0';
                
    CounterEnable <= '1' when ( State = RECEIVING_DATA OR State = RECEIVING_INIT )
                else '0';
    
    
end Behavioral;
