
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dataRegister_tb is
end dataRegister_tb;

architecture Behavioral of dataRegister_tb is

COMPONENT dataRegister Port ( 
                                   DataIn       : in STD_LOGIC_VECTOR (127 downto 0);
                                   Load_enable  : in STD_LOGIC;
                                   DataOut      : out STD_LOGIC_VECTOR (127 downto 0);
                                   Clk          : in STD_LOGIC;
                                   Resetn       : in STD_LOGIC
                            );
end COMPONENT;

-- constants
constant clk_period : time := 20ns;


--data in
signal DataIn       : STD_LOGIC_VECTOR ( 127 downto 0 ) := x"00000000000000000000000000000000";
signal Load_enable  : STD_LOGIC := '0';
signal Clk          : STD_LOGIC := '0';
signal Resetn       : STD_LOGIC := '0';

-- data out
signal DataOut      : STD_LOGIC_VECTOR ( 127 downto 0 );


begin

UUT : dataRegister  PORT MAP ( 
                    DataIn => DataIn, 
                    Load_enable => Load_enable, 
                    DataOut => DataOut, 
                    Clk => Clk, 
                    Resetn => Resetn );

clkProc : process begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;    
end process;

stimProc : process begin
    wait for 15ns;
    Resetn <= '1';
    
    wait until rising_edge(clk);
    DataIn <= X"12345678123456781234567812345678";
    Load_enable <= '1';
    wait until rising_edge(clk);
    DataIn <= x"00000000000000000000000000000000";
    Load_enable <= '0';
    
    wait for 7ns;
    Resetn <= '0';
    
    wait for 100ns;
end process;

end Behavioral;
