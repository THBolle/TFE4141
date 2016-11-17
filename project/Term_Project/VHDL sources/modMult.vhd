library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modMult is
    Generic ( width                 :     positive := 128 );
    Port    ( A, B, n               : in  STD_LOGIC_VECTOR (width-1 downto 0);
              rst_n, clk, start     : in  STD_LOGIC;
              finished              : out STD_LOGIC;
              C                     : out STD_LOGIC_VECTOR (width-1 downto 0));
end modMult;

architecture Behavioral of modMult is

    component modMultFSM
        Generic ( width                         :     natural );
        Port    ( clk, rst_n, start             : in  STD_LOGIC;
                  reset_C, MSAL_run, finished   : out STD_LOGIC;
                  B_index                       : out natural );
    end component modMultFSM;
    
    component modMultMSA is
        Generic ( width : positive );
        Port ( A, B, n : in STD_LOGIC_VECTOR (width-1 downto 0);
                   clk, rst_n, reset_C, MSAL_run : in STD_LOGIC;
                   B_index : in natural;
                   C : out STD_LOGIC_VECTOR (width-1 downto 0) );
    end component modMultMSA;
    
    signal reset_C, MSAL_run : STD_LOGIC;
    signal B_index : natural;
    
begin

    FSM     :   modMultFSM  GENERIC MAP ( width => width )
                            PORT MAP    ( clk => clk,
                                          rst_n => rst_n,
                                          start => start,
                                          reset_C => reset_C,
                                          MSAL_run => MSAL_run,
                                          finished => finished,
                                          B_index => B_index );
    
    MSA     :   modMultMSA  GENERIC MAP ( width => width )
                            PORT MAP    ( A => A,
                                          B => B,
                                          n => n,
                                          clk => clk,
                                          rst_n => rst_n,
                                          reset_C => reset_C,
                                          MSAL_run => MSAL_run,
                                          B_index => B_index,
                                          C => C );

end Behavioral;
