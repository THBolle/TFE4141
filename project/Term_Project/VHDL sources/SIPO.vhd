
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity SIPO is
    Port ( DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           Enable : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           ParallelOut : out STD_LOGIC_VECTOR (127 downto 0);
           DaisyChainOut : out STD_LOGIC_VECTOR ( 31 downto 0 ) 
          );
end SIPO;

-- Daisychain out is 4 clk signals delayed version of DataIn

architecture Behavioral of SIPO is
    
       signal nextParOutput : STD_LOGIC_VECTOR (127 downto 0);

begin


    -- use internal signal and clock condition to generate register 
    process(CLK,Resetn, Enable)             
        begin
    
            if ( Resetn = '0') then
                nextParOutput ( 127 downto 0 ) <= std_logic_vector(to_unsigned(0,128));
 
            elsif ( rising_edge(CLK) AND Enable = '1' ) then
                    nextParOutput(95 downto 0)    <= nextParOutput(127 downto 32);
                    nextParOutput(127 downto 96 )     <= DataIn(31 downto 0);
            end if;
    
        end process;
        
        -- set output with combinatorial logic to avoid extra registers:
        ParallelOut(127 downto 0) <= nextParOutput(127 downto 0 );
        DaisyChainOut ( 31 downto 0 )  <= nextParOutput ( 31 downto 0 );

end Behavioral;
