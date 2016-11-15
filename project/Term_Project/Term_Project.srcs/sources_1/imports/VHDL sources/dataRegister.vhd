----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2016 09:04:46 PM
-- Design Name: 
-- Module Name: dataRegister - Behavioral
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

entity dataRegister is
    Port ( DataIn : in STD_LOGIC_VECTOR (127 downto 0);
           Load_enable : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (127 downto 0);
           Clk : in STD_LOGIC;
           Resetn : in STD_LOGIC);
end dataRegister;

architecture Behavioral of dataRegister is
    signal internalRegValue : STD_LOGIC_VECTOR ( 127 downto 0 );
begin

LOAD : process ( Resetn, clk, Load_enable ) begin
    if ( Resetn = '0' ) then
        internalRegValue <= x"00000000000000000000000000000000";
    elsif ( rising_edge(Clk) AND Load_enable = '1') then
        internalRegValue ( 127 downto 0 ) <= DataIn(127 downto 0 );
    end if; 
end process; 

    DataOut (127 downto 0 ) <= internalRegValue ( 127 downto 0);



end Behavioral;
