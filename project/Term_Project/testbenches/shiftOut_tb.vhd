LIBRARY ieee;
use ieee.std_logic_1164.all;
--use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_out_tb is
end shift_out_tb;

architecture Behavioural of shift_out_tb is
    component shiftOut
    Port ( clk, rst_n, startShiftOut    : in  STD_LOGIC;
           M                            : in  STD_LOGIC_VECTOR (127 downto 0);
           DataShiftComplete            : out STD_LOGIC;
           DataOut                      : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal clk, rst_n, startShiftOut : std_logic := '0';
    signal M : std_logic_vector(127 downto 0) := x"00112233445566778899AABBCCDDEEFF";
    signal DataShiftComplete : std_logic;
    signal DataOut : std_logic_vector (31 downto 0);
    
    constant clk_period : time := 20 ns;
begin
    
    UUT : shiftOut PORT MAP (
                clk => clk,
                rst_n => rst_n,
                startShiftOut => startShiftOut,
                M => M,
                DataShiftComplete => DataShiftComplete,
                DataOut => DataOut
            );       
    
    CLKGEN: process begin
        clk <= not clk;
        wait for clk_period/2;
    end process;
        
    STIM_PROC: process begin
        wait for clk_period/2;
        rst_n <= '1';
        wait for clk_period/2;
        startShiftOut <= '1';
        wait for clk_period;
        startShiftOut <= '0';
        wait until DataShiftComplete <= '1';
        wait for 2*clk_period;
        assert true;
            report "simulation ended"
            severity failure;
    end process;
    
end Behavioural;