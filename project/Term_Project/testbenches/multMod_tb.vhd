library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multMod_tb is
end multMod_tb;

architecture testbench of multMod_tb is
    
    component multMod is
        generic ( width         : integer := 8 );
        port (  clk, rst, run   : in STD_LOGIC := '0';
                busy        : out STD_LOGIC;
                A, B, N         : in STD_LOGIC_VECTOR (width-1 downto 0) := x"00";
                C               : out STD_LOGIC_VECTOR (width-1 downto 0));
    end component multMod;
    
    constant width          : integer                           := 8;
    signal clk, rst, run    : STD_LOGIC                         := '0';
    signal busy             : STD_LOGIC;
    signal A                : STD_LOGIC_VECTOR (width-1 downto 0)   := "00000111";
    signal B                : STD_LOGIC_VECTOR (width-1 downto 0)   := "00001010";
    signal N                : STD_LOGIC_VECTOR (width-1 downto 0)   := "00011000";
    signal C                : STD_LOGIC_VECTOR (width-1 downto 0);
    constant clk_period : time := 20 ns;
    
begin

    GENERICS:   multMod generic map ( width => width );
    PORTS:      multMod port map (
        clk => clk,
        rst => rst,
        run => run,
        busy => busy,
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
        wait for clk_period;
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period;
        run <= '1';
        wait for clk_period;
        run <= '0';
        wait;
    end process;
    
end testbench;


