----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2016 02:35:55 PM
-- Design Name: 
-- Module Name: PISO128to1 - Behavioral
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

entity PISO128to1 is
    Port ( DataIn : in STD_LOGIC_VECTOR (127 downto 0);
           Enable : in STD_LOGIC;
           Shift_load : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           DataOut : out STD_LOGIC;
           RegEmpty : out STD_LOGIC);
end PISO128to1;

architecture Behavioral of PISO128to1 is

    signal internalData : STD_LOGIC_VECTOR ( 127 downto 0 );
    signal gatedClk : STD_LOGIC;

begin


LOAD_proc : process ( Resetn, Clk, Shift_load, enable ) 
    begin
    if ( Resetn = '0' ) then
        internalData <= x"00000000000000000000000000000000";
    elsif ( rising_edge( Clk) AND enable = '1' ) then
        
            if ( Shift_load = '1' ) then 
                internalData(126 downto 0) <= internalData ( 127 downto 1 );
                internalData(127) <= '0';
            else 
                internalData(127 downto 0 ) <= DataIn ( 127 downto 0 );
            end if;
    end if;
end process;  



DataOut <= internalData(0);
RegEmpty <= '1' when internalData(127 downto 0) = x"00000000000000000000000000000000" else '0';


end Behavioral;
