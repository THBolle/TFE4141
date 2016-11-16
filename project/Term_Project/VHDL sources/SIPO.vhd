----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2016 02:40:53 PM
-- Design Name: 
-- Module Name: negEdgeSIPO - Behavioral
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

entity SIPO is
    Port ( DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           Enable : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           ParallelOut : out STD_LOGIC_VECTOR (127 downto 0);
           DaisyChainOut : out STD_LOGIC_VECTOR ( 31 downto 0 ) -- for daisy chain config of registers
          );
end SIPO;

architecture Behavioral of SIPO is
    
       signal nextParOutput : STD_LOGIC_VECTOR (127 downto 0);

begin


    -- use internal signal and clock condition to generate register 
    process(CLK,Resetn, Enable)             
        begin
    
            if ( Resetn = '0') then
                nextParOutput ( 127 downto 0 ) <= std_logic_vector(to_unsigned(0,128));
 
            elsif ( rising_edge(CLK) AND Enable = '1' ) then
                    nextParOutput(127 downto 32)    <= nextParOutput(95 downto 0);
                    nextParOutput(31 downto 0 )     <= DataIn(31 downto 0);
            end if;
    
        end process;
        
        -- set output with combinatorial logic to avoid extra registers:
        ParallelOut(127 downto 0) <= nextParOutput(127 downto 0 );
        DaisyChainOut ( 31 downto 0 )  <= nextParOutput ( 127 downto 96 );

end Behavioral;
