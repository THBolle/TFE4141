----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2016 08:38:20 AM
-- Design Name: 
-- Module Name: ModExp_stateMachine - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ModExp_stateMachine is
    Port ( Clk : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           DataReady : in STD_LOGIC;
           E_LSB : in STD_LOGIC;
           Start_Mpow2 : out STD_LOGIC;
           Start_MC : out STD_LOGIC;
           Done_MPow2 : in STD_LOGIC;
           Done_MC : in STD_LOGIC;
           Load_data : out STD_LOGIC;
           exp_done : out STD_LOGIC;
           shift_load_E : out STD_LOGIC;
           M_input_source_sel : out STD_LOGIC
         );
end ModExp_stateMachine;

    

architecture Behavioral of ModExp_stateMachine is

    TYPE FSM_STATES is ( IDLE, LOAD_DATA_FROM_INPUT, STORE_AND_RELOAD ,START_MULT, WAIT_MULT, DONE );
    signal state : FSM_STATES; 
    
    signal mult_counter : UNSIGNED ( 7 downto 0 );
    
    constant SHIFT_E : STD_LOGIC := '1';
    constant LOAD_E  : STD_LOGIC := '0';
    constant INPUT_SOURCE   : STD_LOGIC := '0';
    constant MPOW2_SOURCE   : STD_LOGIC := '1';
    
    
begin

    process (Resetn, Clk ) 
    
    variable multipliersDone : STD_LOGIC;
    variable mult_counter_limit : UNSIGNED ( 7 downto 0);
    
    begin 
    
       
    
        if (Resetn = '0') then
            state <= IDLE;
            mult_counter <= to_unsigned(0,8);
        elsif ( rising_edge ( Clk ) ) then 
            case state is
                when IDLE => 
                    if DataReady = '1' then
                        state <= LOAD_DATA_FROM_INPUT;
                        mult_counter <= to_unsigned(0,8); 
                    else 
                        state <= IDLE;
                        mult_counter <= to_unsigned(0,8);
                    end if;
                 
                when LOAD_DATA_FROM_INPUT =>
                        state <= START_MULT;
                        mult_counter <= mult_counter;
                        
                when START_MULT =>
                    State <= WAIT_MULT;
                    mult_counter <= mult_counter;
                    
                when WAIT_MULT =>
                     if E_LSB = '0' then
                        multipliersDone := Done_MPow2;
                     else 
                        multipliersDone := Done_MPow2 and Done_MC;
                     end if;
                     mult_counter_limit := to_unsigned(127,8);
                    
                    if (multipliersDone = '1' and mult_counter < mult_counter_limit) then 
                        State <= STORE_AND_RELOAD;
                        mult_counter <= mult_counter + 1;
                    elsif ( multipliersDone = '1' and mult_counter >= mult_counter) then
                        State <= DONE;
                        mult_counter <= to_unsigned(0,8);
                    else 
                        State <= WAIT_MULT;
                        mult_counter <= mult_counter;
                    end if;
                    
                when STORE_AND_RELOAD =>
                    State <= START_MULT;
                    mult_counter <= mult_counter;
                    
                when DONE =>
                    State <= IDLE;
                    mult_counter <= mult_counter;
            end case;
        end if;  
    end process;
    
    -- combinatorial outputs:
    
    Start_Mpow2 <= '1' when State = START_MULT else '0';
    Start_MC    <= '1' when State = START_MULT and E_LSB = '1' else '0';
    Load_data <= '1' when State = LOAD_DATA_FROM_INPUT or State = STORE_AND_RELOAD else '0';
    exp_done <= '1' when State = Done else '0';
    shift_load_E <= LOAD_E when state = LOAD_DATA_FROM_INPUT else SHIFT_E;
    M_input_source_sel <= INPUT_SOURCE when state = LOAD_DATA_FROM_INPUT else MPOW2_SOURCE;
    

end Behavioral;
