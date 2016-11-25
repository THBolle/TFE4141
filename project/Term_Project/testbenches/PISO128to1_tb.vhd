
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PISO128to1_tb is
--  Port ( );
end PISO128to1_tb;

architecture Behavioral of PISO128to1_tb is

    COMPONENT PISO128to1 
    Port ( DataIn : in STD_LOGIC_VECTOR (127 downto 0);
           Enable : in STD_LOGIC;
           Shift_load : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           DataOut : out STD_LOGIC;
           RegEmpty : out STD_LOGIC);
    end COMPONENT;
    
    -- constants
    constant Clk_period : time := 20ns;
    constant SHIFT : STD_LOGIC := '1';
    constant LOAD  : STD_LOGIC := '0';
    -- inputs
    signal DataIn : STD_LOGIC_VECTOR ( 127 downto 0 ) := x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    signal Clk :STD_LOGIC :='0';
    signal Enable : STD_LOGIC := '0';
    signal Resetn : STD_LOGIC := '0';
    signal Shift_load : STD_LOGIC := LOAD;
    
    -- outputs
    signal DataOut : STD_LOGIC;
    signal RegEmpty : STD_LOGIC;
    
   

begin


    UUT: PISO128to1 PORT MAP (   DataIn => DataIn,
                           Enable => Enable,
                           Shift_load => Shift_load,
                           Clk => Clk,
                           Resetn => Resetn,
                           DataOut => DataOut,
                           RegEmpty => RegEmpty
                       );
                       
    clk_proc : process begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
    end process;
    
    stim_proc : process begin
        wait for 23ns;
        Resetn <= '1';
        wait until rising_edge(Clk);
        Enable <= '1';
        wait until rising_edge(CLK);
        Enable <= '0';
        DataIn <= x"00000000000000000000000000000000";
        wait until rising_edge(CLK);
        Shift_load <= SHIFT;
        Enable <= '1';
        
        for i in 0 to 127 loop
            wait until rising_edge(Clk);
        end loop;
        
        wait for 1000ns;
        
        
    end process;
        
        


end Behavioral;
