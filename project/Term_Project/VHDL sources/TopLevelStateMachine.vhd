library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity TopLevelStateMachine is
    Port ( InitRsa : in STD_LOGIC;
           StartRsa : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           ExpDone: in STD_LOGIC;
           dataShiftedOut : in STD_LOGIC;
           
           DataReceived : out STD_LOGIC;
           EnableDataReg : out STD_LOGIC;
           EnableCtrlReg : out STD_LOGIC;
           CoreFinishedn : out STD_LOGIC);
end TopLevelStateMachine;



architecture Behavioral of TopLevelStateMachine is

    type FSM_STATES is ( IDLE, RECEIVING_INIT, RECEIVING_DATA, PROCESSING, DONE  );
    
    signal state : FSM_STATES;

    signal dataCounter : unsigned ( 3 downto 0 );

begin


    reset : process ( InitRsa, StartRsa, Clk, Resetn ) begin
    
        if ( Resetn = '0' ) then 
            state <= IDLE;
            dataCounter <= to_unsigned(0,4);
        elsif rising_edge(Clk) then
         
            case state is
            
                when IDLE => 
                        dataCounter <= to_unsigned(0,4);
                        if InitRsa = '1' then
                            state <= RECEIVING_INIT;
                        elsif ( StartRsa = '1') then
                            state <= RECEIVING_DATA;
                        end if;  
                
                when RECEIVING_INIT =>
                        dataCounter <= dataCounter + 1;
                        if (dataCounter = x"6") then
                            state <= IDLE;
                        end if;
                         
                when RECEIVING_DATA =>
                        dataCounter <= dataCounter + 1;
                        if ( dataCounter = x"2") then
                            state <= PROCESSING;
                        end if;
                        
                when PROCESSING =>
                        if ( ExpDone = '1') then
                            state <= DONE;
                        end if;
                when DONE =>
                       -- if (dataShiftedOut = '1') then
                            state <= IDLE;
                       -- end if;    
                 
              end case;  
              
                              
        end if;
    end process;
    
    -- Output logic
    DataReceived <= '1' when  ( State = PROCESSING)
               else '0';  
   

    
    EnableDataReg <= '1' when ( State = IDLE AND StartRsa = '1' ) OR ( State = RECEIVING_DATA)
                else '0';
                
    EnableCtrlReg <= '1' when ( State = IDLE AND InitRsa = '1' ) OR ( State = RECEIVING_INIT)
                else '0';
    
    CoreFinishedn <= '1' when ( State = IDLE OR State = DONE OR InitRsa = '1' OR StartRsa = '1')
                else '0';
                
    
end Behavioral;
