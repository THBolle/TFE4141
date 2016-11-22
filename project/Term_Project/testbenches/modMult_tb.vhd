library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modMult_tb is
end modMult_tb;

architecture testbench of modMult_tb is
    component modMult is
        Generic ( width : integer );
        Port ( A, B, n : in STD_LOGIC_VECTOR (width-1 downto 0) := x"00000000000000000000000000000000";
               rst_n, clk, start : in STD_LOGIC := '0';
               finished : out STD_LOGIC;
               C : out STD_LOGIC_VECTOR (width-1 downto 0));          
    end component modMult;
    
    constant width              : integer                               := 128;
    signal clk, rst_n, start    : STD_LOGIC                             := '0';
    signal finished             : STD_LOGIC;
    signal A                    : STD_LOGIC_VECTOR (width-1 downto 0)   := x"00000000000000000000000000000000";-- x"434e76d7965f50afa6d6af593e753085";
    signal B                    : STD_LOGIC_VECTOR (width-1 downto 0)   := x"00000000000000000000000000000000";--x"0c21dafc9c270f489acb80fb1cdfa127";
    signal N                    : STD_LOGIC_VECTOR (width-1 downto 0)   := x"B19DC6B2574E12C3C8BC49CDD79555FD"; --x"52f201d560c0db8d410611c8a5ce1123";
    signal C                    : STD_LOGIC_VECTOR (width-1 downto 0);  --   34c10b0a2b6e7fbf76bfbe47bed76a54
    constant clk_period : time := 20 ns;
begin

    GENERICS:   modMult generic map ( width )
                           port map ( A, B, n, rst_n, clk, start, finished, C );
    
    CLKGEN: process begin
        clk <= not clk;
        wait for clk_period/2;
    end process;
    
    STIM_PROC: process begin
        rst_n <= '0';
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
        assert(C = x"7f021b0c74da40bc00a73216d0fe35b2");
    end process;
    
end testbench;
