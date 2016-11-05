----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2016 01:20:07 PM
-- Design Name: 
-- Module Name: inputRegister - Behavioral
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

entity inputRegister is
    Port ( CLK : in STD_LOGIC;
           InitRsa : in STD_LOGIC;
           StartRsa : in STD_LOGIC;
           DataIn : in STD_LOGIC;
           M : out STD_LOGIC_VECTOR (127 downto 0);
           KeyN : in STD_LOGIC_VECTOR (127 downto 0);
           KeyE : in STD_LOGIC_VECTOR (127 downto 0));
end inputRegister;

architecture Behavioral of inputRegister is
begin
   DataPath: process (
    
    

end Behavioral;
