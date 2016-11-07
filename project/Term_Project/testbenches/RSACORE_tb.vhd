----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2016 07:08:02 PM
-- Design Name: 
-- Module Name: RSACORE_tb - Behavioral
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

entity RSACORE_tb is
--  Port ( );
end RSACORE_tb;

architecture Behavioral of RSACORE_tb is

    COMPONENT  RSACore 
Port (   Clk : in STD_LOGIC;
                                Resetn : in STD_LOGIC;
                                InitRsa : in STD_LOGIC;
                                StartRsa : in STD_LOGIC;
                                DataIn : in STD_LOGIC_VECTOR (31 downto 0);
                                DataOut : out STD_LOGIC_VECTOR (31 downto 0);
                                CoreFinished : out STD_LOGIC
                             );
   END COMPONENT;
   


    constant clk_period : time  := 20ns;
    
    -- input signals
    signal Clk : STD_LOGIC := '0';
    signal Resetn : STD_LOGIC := '0';
    signal InitRsa : STD_LOGIC := '0';
    signal StartRsa : STD_LOGIC := '0';
    signal DataIn : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
    
    --output signals
    signal DataOut : STD_LOGIC_VECTOR (31 downto 0);
    signal CoreFinished : STD_LOGIC;
    
begin
    UUT: RSACore PORT MAP ( 
                            Clk => Clk,
                            Resetn => Resetn,
                            InitRsa => InitRsa,
                            StartRsa => StartRsa,
                            DataIn => DataIn,
                            CoreFinished => CoreFinished
                            );
                            
    
    clk_process : process begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    
    stim_process : process begin
    
    wait for 7ns;
    Resetn <= '1';
    wait until rising_edge(Clk);
    InitRsa <= '1';
    DataIn <= x"11111111";
    wait until rising_edge(Clk);
    InitRsa <= '0';
    DataIn <= x"22222222";
    wait until rising_edge(Clk);
    DataIn <= x"33333333";
    wait until rising_edge(Clk);
    DataIn <= x"44444444";
    wait until rising_edge(Clk);
    DataIn <= x"00000000";
        
    wait until rising_edge(CoreFinished);
    wait until rising_edge(Clk);
    StartRsa <= '1';
    DataIn <= x"11111111";
    wait until rising_edge(Clk);
    StartRsa <= '0';
    DataIn <= x"22222222";
    wait until rising_edge(Clk);
    DataIn <= x"33333333";
    wait until rising_edge(Clk);
    DataIn <= x"44444444";
    wait until rising_edge(Clk);
    DataIn <= x"00000000";
    
    wait for 1000ns;
            
            
    end process;

end Behavioral;
