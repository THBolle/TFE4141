
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Sipo_tb is
end Sipo_tb;

architecture Behavioral of Sipo_tb is

    COMPONENT Sipo Port (    DataIn : in STD_LOGIC_VECTOR (31 downto 0);
                                    CLK : in STD_LOGIC;
                                    Enable : in STD_LOGIC;
                                    Resetn : in STD_LOGIC;
                                    ParallelOut : out STD_LOGIC_VECTOR (127 downto 0);
                                    DaisyChainOut : out STD_LOGIC_VECTOR ( 31 downto 0 ) -- for daisy chain config of registers
                                );
    end COMPONENT;

    --constants
    constant clk_period : time  := 20ns;

    -- Inputs:
    signal CLK      : std_logic := '0';
    signal Resetn   : std_logic := '0';
    signal Enable   : std_logic := '0';
    signal DataIn   : std_logic_vector(31 downto 0)  := x"00000000";
   
    
    -- Outputs:
    signal ParallelOut : std_logic_vector(127 downto 0);
    signal ChainOut : std_logic_vector(31 downto 0);

begin
    UUT: Sipo PORT MAP ( DataIn=> DataIn, CLK => CLK, Enable =>Enable, Resetn=>Resetn,ParallelOut =>ParallelOut,DaisyChainOut => ChainOut);
    
    clk_process : process begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
     end process;
    
    stim_proc: process begin
        DataIn <= x"A5A5A5A5";
        wait for 157ns;
        
        Resetn <= '1';
        wait for 43ns;
        wait until rising_edge(CLK);
        enable <= '1';
        wait until rising_edge(CLK);
        DataIn <= x"DEADBEEF";
        wait until rising_edge(CLK);
        DataIn <= x"AAAAAAAA";
        wait until rising_edge(CLK);
        DataIn <= x"11111111";
        wait until rising_edge(CLK);
        wait until rising_edge(CLK);
        wait until rising_edge(CLK);
        wait until rising_edge(CLK);                        
        enable <= '0';
        wait for 1000ns;
        
        Resetn <= '0';
        wait for 1000ns;
    
        wait;
    end process;

end Behavioral;
