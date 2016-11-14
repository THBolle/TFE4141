----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2016 08:34:31 AM
-- Design Name: 
-- Module Name: ModExp_stateMachine_tb - Behavioral
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

entity ModExp_stateMachine_tb is
--  Port ( );
end ModExp_stateMachine_tb;

architecture Behavioral of ModExp_stateMachine_tb is

COMPONENT ModExp_stateMachine port ( 
                                     Clk : in STD_LOGIC;
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
    end COMPONENT;                               
    -- inputs
    signal Clk : STD_LOGIC := '0';
    signal DataReady : STD_LOGIC := '0';
    signal E_LSB : STD_LOGIC := '0';
    signal Done_Mpow2 : STD_LOGIC :='0';
    signal Done_MC : STD_LOGIC := '0';
    signal Resetn : STD_LOGIC := '0';
    -- outputs
    signal Start_Mpow2 : STD_LOGIC;
    signal Start_MC : STD_LOGIC;
    signal Load_data : STD_LOGIC;
    signal exp_done : STD_LOGIC;
    signal Shift_load_E : STD_LOGIC;
    signal M_input_source_sel : STD_LOGIC;
    -- constants                             
    constant clk_period : time := 20ns;
begin

UUT : ModExp_stateMachine PORT MAP ( 
                                     Clk => Clk  ,
                                     Resetn => Resetn ,  
                                     DataReady => DataReady ,
                                     E_LSB => E_LSB ,
                                     Start_Mpow2 => Start_Mpow2 ,
                                     Start_MC => Start_MC ,
                                     Done_MPow2 => Done_MPow2 ,
                                     Done_MC => Done_MC ,
                                     Load_data => Load_data ,
                                     exp_done => exp_done ,
                                     shift_load_E => shift_load_E ,
                                     M_input_source_sel=>M_input_source_sel
                                    );

clk_process : process begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
     end process;
     
stim_process : process begin
    
    wait for 7ns;
    resetn <= '1';
    
    wait until rising_edge(Clk);
    DataReady <= '1';
    
    wait for 200ns;
    wait until rising_edge(Clk);
    Done_Mpow2 <= '1';
    Done_MC <= '1';
    wait until rising_edge(Clk);
    Done_MC <= '0';
    for i in 0 to 128 loop
        wait for 200ns;
        wait until rising_edge(Clk);
        Done_Mpow2 <= '1';
        Done_MC <= '1';
        wait until rising_edge(Clk);
        Done_MC <= '0';
    end loop;
    
    
    wait for 200ns;
    
    
    
end process;



end Behavioral;
