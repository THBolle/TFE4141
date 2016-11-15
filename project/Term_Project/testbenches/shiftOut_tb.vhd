LIBRARY ieee;
use ieee.std_logic_1164.all;
--use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_out_tb is
end shift_out_tb;

architecture Behavioural of shift_out_tb is
    component shift_out
    Port ( Clk              : in  STD_LOGIC;
           Reset            : in  STD_LOGIC;
           M                : in  STD_LOGIC_VECTOR (127 downto 0);
           StartShiftOut    : in  STD_LOGIC;
           DataOut          : out STD_LOGIC_VECTOR ( 31 downto 0);
           CoreFinished     : out STD_LOGIC);
    end component;
    
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal M : std_logic_vector(127 downto 0) := x"0123456789ABCDEF";
    constant clk_period : time := 20 ns;
begin
    
    UUT : shift_out_tb PORT MAP (
                Clk => Clk,
                Reset => Reset,
                M => M                
            );       
    
    CLKGEN: process(M) is
    begin
        Clk <= '1';
        wait for clk_period/2 ns;
        Clk <= '0';
        wait for clk_peroid/2 ns;
    end process;
        
    STIM_PROC: process is
    begin
        reset <= '0';
        wait;
    end process;
    
end Behavioural;