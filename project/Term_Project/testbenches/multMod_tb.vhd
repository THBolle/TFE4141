--Lars

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multMod_tb is
end multMod_tb;

architecture testbench of multMod_tb is
    
    component multMod is
    port (  clk, rst, run   : in  STD_LOGIC;
            finished        : out STD_LOGIC;
            A, B, N         : in  STD_LOGIC_VECTOR (127 downto 0);
            --C               : out STD_LOGIC_VECTOR (127 downto 0));
            P               : inout STD_LOGIC_VECTOR (255 downto 0));
    end component multMod;
    
    signal clk, rst, run    : STD_LOGIC                         := '0';
    signal finished         : STD_LOGIC;--                         := '0';
    signal A                : STD_LOGIC_VECTOR (127 downto 0)   := x"00000000000000000000000000000111";
    signal B                : STD_LOGIC_VECTOR (127 downto 0)   := x"00000000000000000000000000001010";
    signal N                : STD_LOGIC_VECTOR (127 downto 0)   := x"00000000000000000000000000011000";
    --signal C                : STD_LOGIC_VECTOR (127 downto 0);--   := x"00000000000000000000000000000000";
    signal P                : STD_LOGIC_VECTOR (255 downto 0);--   := x"00000000000000000000000000000000";
    constant clk_period : time := 20 ns;
    
begin

    PORTS: multMod port map (
        clk => clk,
        rst => rst,
        run => run,
        finished => finished,
        A => A,
        B => B,
        N => N,
        --C => C
        P => P
    );
    
    CLKGEN: process begin
        clk <= '0';
        wait for 10ns;
        clk <= '1';
        wait for clk_period/2;
    end process;

    
    STIM_PROC: process begin
        rst <= '1';
        wait for 3*clk_period/2;
        rst <= '0';
        wait for clk_period;
        run <= '1';
        wait for 3*clk_period/2;
        run <= '0';
        wait;
    end process;
    
end testbench;

