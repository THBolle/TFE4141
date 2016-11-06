----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2016 06:46:56 PM
-- Design Name: 
-- Module Name: DataInDEMUX - Behavioral
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

entity DataInDEMUX is
    Port ( DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           DataOutA : out STD_LOGIC_VECTOR (31 downto 0);
           DataOutB : out STD_LOGIC_VECTOR (31 downto 0);
           Sel : in STD_LOGIC
          );
          
end DataInDEMUX;

architecture Behavioral of DataInDEMUX is


    


begin


end Behavioral;
