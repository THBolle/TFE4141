library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modMult_tb is
end modMult_tb;

architecture testbench of modMult_tb is
    
    component modMult is
        Generic ( width : natural );
        Port ( A, B, n : in STD_LOGIC_VECTOR (width-1 downto 0) := x"00";
               rst, clk, start : in STD_LOGIC := '0';
               finished : out STD_LOGIC;
               C : out STD_LOGIC_VECTOR (width-1 downto 0));          
    end component modMult;
    
    constant width          : natural                           := 8;
    signal clk, rst, start  : STD_LOGIC                         := '0';
    signal finished         : STD_LOGIC;
    signal A                : STD_LOGIC_VECTOR (width-1 downto 0)   := x"65";
    signal B                : STD_LOGIC_VECTOR (width-1 downto 0)   := x"2e";
    signal N                : STD_LOGIC_VECTOR (width-1 downto 0)   := x"ae";
    signal C                : STD_LOGIC_VECTOR (width-1 downto 0);
    constant clk_period : time := 20 ns;
begin

    COMP:   modMult generic map ( width => width )
                    port map (
                                clk => clk,
                                rst => rst,
                                start => start,
                                finished => finished,
                                A => A,
                                B => B,
                                N => N,
                                C => C
                            );
    
    CLKGEN: process begin
        clk <= not clk;
        wait for clk_period/2;
    end process;

    
    STIM_PROC: process begin
        rst <= '1';
        wait for clk_period/2;
        rst <= '0';
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait;
    end process;
    
end testbench;
