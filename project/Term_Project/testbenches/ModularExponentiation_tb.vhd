----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2016 05:28:41 PM
-- Design Name: 
-- Module Name: ModularExponentiation_tb - Behavioral
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

entity ModularExponentiation_tb is
--  Port ( );
end ModularExponentiation_tb;

architecture Behavioral of ModularExponentiation_tb is

COMPONENT ModularExponentiation Port ( 
                                        M : in STD_LOGIC_VECTOR (127 downto 0);
                                        E : in STD_LOGIC_VECTOR (127 downto 0);
                                        DataInReady : in STD_LOGIC;
                                        Clk : in STD_LOGIC;
                                        Resetn : in STD_LOGIC;
                                        ExpDone : out STD_LOGIC;
                                        C : out STD_LOGIC_VECTOR (127 downto 0)
                                     );
end COMPONENT;

    --constants
    constant clk_period : time := 20ns; 
    -- inputs
    signal M : STD_LOGIC_VECTOR ( 127 downto 0 ) := x"00000000000000000000000000000000";
    signal E : STD_LOGIC_VECTOR ( 127 downto 0 ) := x"00000000000000000000000000000000";
    signal Clk : STD_LOGIC := '0';
    signal Resetn : STD_LOGIC := '0';
    signal DataInReady : STD_LOGIC := '0';
         
    --outputs
    signal ExpDone : STD_LOGIC;
    signal C : STD_LOGIC_VECTOR ( 127 downto 0 );


begin

    UUT : ModularExponentiation PORT MAP ( M => M, E => E, Clk => Clk,DataInReady => DataInReady, Resetn => Resetn, ExpDone => ExpDone, C => C );

    Clkproc : process begin
        Clk <= '0';
        wait for clk_period;
        Clk <= '1';
        wait for clk_period;
    end process;

    stimProc : process begin
    
        wait for 7ns;
        Resetn <= '1';
        wait until rising_edge(Clk);
        M ( 127 downto 0 ) <= x"12345678123456781234567812345678";
        E ( 127 downto 0 ) <= x"5555AAAA5555AAAA5555AAAA5555AAAA";
        wait until rising_edge(Clk);
        DataInReady <= '1';
        wait for 20ns;
    end process;
    

end Behavioral;
