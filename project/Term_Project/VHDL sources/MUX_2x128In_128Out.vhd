

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_2x128In_128Out is
    Port ( InA : in STD_LOGIC_VECTOR (127 downto 0);
           InB : in STD_LOGIC_VECTOR (127 downto 0);
           Sel : in STD_LOGIC;
           OutA : out STD_LOGIC_VECTOR (127 downto 0));
end MUX_2x128In_128Out;

architecture Behavioral of MUX_2x128In_128Out is

begin

mux : process (inA, inB, sel) begin 
    if ( sel = '0') then
        OutA (127 downto 0) <= inA ( 127 downto 0 );
    else 
        OutA (127 downto 0) <= inB (127 downto 0);
    end if;
end process;

end Behavioral;
