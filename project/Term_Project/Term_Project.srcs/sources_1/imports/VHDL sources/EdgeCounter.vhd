----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2016 07:46:05 PM
-- Design Name: 
-- Module Name: NegEdgeCounter - Behavioral
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

entity EdgeCounter is
        generic ( countWidth : integer := 8);
    Port ( Enable : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           CountVal : out STD_LOGIC_VECTOR (countWidth-1 downto 0));
end EdgeCounter;

architecture Behavioral of EdgeCounter is
    
   signal internalCountVal : UNSIGNED ( countWidth-1 downto 0 );
    
begin
    
    count : process ( Clk, Resetn, Enable ) 
    begin
        
        if ( Resetn = '0' or rising_edge(Enable) ) then 
            internalCountVal <= to_unsigned(0,countWidth);
        elsif( rising_edge(Clk) AND Enable = '1' ) then 
            internalCountVal <= internalCountVal + 1;
        end if;
            
    end process;
    
    
    CountVal <= std_logic_vector(internalCountVal); 


end Behavioral;
