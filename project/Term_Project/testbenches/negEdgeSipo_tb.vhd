----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2016 03:07:56 PM
-- Design Name: 
-- Module Name: negEdgeSipo_tb - Behavioral
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

entity negEdgeSipo_tb is
end negEdgeSipo_tb;

architecture Behavioral of negEdgeSipo_tb is

    COMPONENT negEdgeSipo Port (    DataIn : in STD_LOGIC_VECTOR (31 downto 0);
                                    CLK : in STD_LOGIC;
                                    Enable : in STD_LOGIC;
                                    Resetn : in STD_LOGIC;
                                    ParallelOut : out STD_LOGIC_VECTOR (127 downto 0)
                                );
    end COMPONENT;

    --constants
    constant clk_period : time  := 20ns;

    -- Inputs:
    signal CLK      : std_logic := '0';
    signal Resetn   : std_logic := '0';
    signal Enable   : std_logic := '0';
    signal DataIn   : std_logic_vector(31 downto 0)  := x"00000000";
    
    -- Outputs:
    signal ParallelOut : std_logic_vector(127 downto 0);

begin
    UUT: negEdgeSipo PORT MAP ( DataIn=> DataIn, CLK => CLK, Enable =>Enable, Resetn=>Resetn,ParallelOut =>ParallelOut);
    
    clk_process : process begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
     end process;
    
    stim_proc: process begin
        DataIn <= x"A5A5A5A5";
        wait for 1000ns;
        
        Resetn <= '1';
        wait for 1000ns;
        
        enable <= '1';
        wait for 1000ns;
        
        Resetn <= '0';
        wait for 1000ns;
    
        wait;
    end process;

end Behavioral;
