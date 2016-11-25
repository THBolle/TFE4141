library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity modMult_tb is
end modMult_tb;

architecture testbench of modMult_tb is
    component modMult is
        Generic ( width : integer );
        Port ( A, B, n  : in STD_LOGIC_VECTOR (width-1 downto 0) 
                        := x"00000000000000000000000000000000";
               rst_n, clk, start : in STD_LOGIC := '0';
               finished : out STD_LOGIC;
               C : out STD_LOGIC_VECTOR (width-1 downto 0));          
    end component modMult;
    
    constant width              : integer                               := 128;
    signal clk, rst_n, start    : STD_LOGIC                             := '0';
    signal finished             : STD_LOGIC;
    signal A                    : STD_LOGIC_VECTOR (width-1 downto 0)   
                                := x"00000000000000000000000000000000";
    
    signal B                    : STD_LOGIC_VECTOR (width-1 downto 0)   
                                := x"00000000000000000000000000000000";
    
    signal N                    : STD_LOGIC_VECTOR (width-1 downto 0)   
                                := x"B19DC6B2574E12C3C8BC49CDD79555FD";
    
    signal C                    : STD_LOGIC_VECTOR (width-1 downto 0);     
    constant clk_period : time := 20 ns;
    
    signal C_expected : STD_LOGIC_VECTOR (width-1 downto 0);
    
begin

    C_expected <= std_logic_vector (
        unsigned(A) * unsigned(B) mod unsigned(n)
    );

    GENERICS:   modMult generic map ( width )
                           port map ( A, B, n, rst_n, clk, start, finished, C );
    
    CLKGEN: process begin
        clk <= not clk;
        wait for clk_period/2;
    end process;
    
    STIM_PROC: process begin
        --rst_n <= '0';
        wait for clk_period/2;
        rst_n <= '1';
        start <= '1';
        A <= x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
        B <= x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
        wait for clk_period;
        start <= '0';
        wait;
    end process;
    
    ASSERTION: process begin
        wait until finished = '1';
        assert C = C_expected
            report "Invalid output"
            severity Failure;
    end process;
    
end testbench;
