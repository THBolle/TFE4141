----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2016 08:10:10 PM
-- Design Name: 
-- Module Name: NegEdgeCounter_tb - Behavioral
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

entity NegEdgeCounter_tb is
--  Port ( );
end NegEdgeCounter_tb;

architecture Behavioral of EdgeCounter_tb is
    
    COMPONENT EdgeCounter 
        generic ( countWidth : integer := 8);
                            Port ( Enable : in STD_LOGIC;
                                    Clk : in STD_LOGIC;
                                    Resetn : in STD_LOGIC;
                                    CountVal : out STD_LOGIC_VECTOR (3 downto 0)
                                   );
    END COMPONENT;

    --constants
    constant clk_period : time  := 20ns;
    
    -- input signals
    signal Enable   : STD_LOGIC := '0';
    signal Clk      : STD_LOGIC := '0';
    signal Resetn   : STD_LOGIC := '0';
    
    --output signals
    
    signal CountVal : STD_LOGIC_VECTOR ( 3 downto 0 );
    

begin

    UUT: EdgeCounter  generic map (countWidth => 4) PORT MAP (  Enable => Enable,
                                    Clk => Clk,
                                    Resetn => Resetn,
                                    CountVal => CountVal
                                  );
                                  
                                  
     clk_process : process begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
     end process;     
     
     
     stim_process : process begin
             wait for 10ns;
             Resetn <= '1';
             wait for 100ns;
             Enable <= '1';
             wait for 100ns;
             Enable <= '0';
             wait for 100ns;
             Enable <= '1';
             wait for 100ns;
             Resetn <= '0';
             wait for 100ns;
             Resetn <= '1';
             wait for 100ns;
             Enable <= '0';
             wait for 100ns;
             Enable <= '1';
             wait;
             
        end process;                        


end Behavioral;
