library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2x128in_128Out_tb is
--  Port ( );
end MUX_2x128in_128Out_tb;

architecture Behavioral of MUX_2x128in_128Out_tb is
    COMPONENT MUX_2x128in_128Out  Port ( 
                                                InA : in STD_LOGIC_VECTOR (127 downto 0);
                                                InB : in STD_LOGIC_VECTOR (127 downto 0);
                                                Sel : in STD_LOGIC;
                                                OutA : out STD_LOGIC_VECTOR (127 downto 0)
                                          );
    end COMPONENT;                                         

    signal InA : STD_LOGIC_VECTOR (127 downto 0 ) := x"12345678123456781234567812345678";
    signal InB : STD_LOGIC_VECTOR (127 downto 0 ) := x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    signal Sel : STD_LOGIC := '0';
    
    signal OutA : STD_LOGIC_VECTOR ( 127 downto 0 );

begin

    UUT : MUX_2x128in_128Out PORT MAP ( InA => InA, InB => InB, Sel => Sel, OutA => OutA);

   
    stim_proc : process begin
    
        wait for 1ns;
        Sel <= '1';
        wait for 1ns;
        Sel <= '0';
        wait for 1ns;
        InA <= x"55555555555555555555555555555555";
        
        wait for 100ns;
        
    end process; 
    
    
end Behavioral;
