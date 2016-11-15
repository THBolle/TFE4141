library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modMult is

    Generic ( width : integer := 8 );
    Port ( A : in STD_LOGIC_VECTOR (width-1 downto 0);
           B : in STD_LOGIC_VECTOR (width-1 downto 0);
           n : in STD_LOGIC_VECTOR (width-1 downto 0);
           rst_n : in STD_LOGIC;
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           finished : out STD_LOGIC;
           C : out STD_LOGIC_VECTOR (width-1 downto 0));
           
   signal MSA_done : std_logic;
   signal rst_MSA : std_logic;
   
end modMult;

architecture Behavioral of modMult is

    component modMultFSM
        Generic ( width : natural );
        Port ( clk : in STD_LOGIC;
               rst_n : in STD_LOGIC;
               start : in STD_LOGIC;
               MSA_done : in STD_LOGIC;
               rst_MSA : out STD_LOGIC;
               finished : out STD_LOGIC);
    end component modMultFSM;
    
    component modMultMSA is
        Generic ( width : natural );
        Port ( A : in STD_LOGIC_VECTOR (width-1 downto 0);
               B : in STD_LOGIC_VECTOR (width-1 downto 0);
               n : in STD_LOGIC_VECTOR (width-1 downto 0);
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               C : out STD_LOGIC_VECTOR (width-1 downto 0);
               MSA_DONE : out STD_LOGIC);
    end component modMultMSA;
    
begin

    FSM     :   modMultFSM  GENERIC MAP ( width => width )
                            PORT MAP (
                                clk => clk,
                                rst_n => rst_n,
                                rst_MSA => rst_MSA,
                                start => start,
                                MSA_done => MSA_done,
                                finished => finished);
    
    MSA     :   modMultMSA  GENERIC MAP ( width => width )
                            PORT MAP (
                                A => A,
                                B => B,
                                n => n,
                                clk => clk,
                                rst => rst_MSA,
                                C => C,
                                MSA_done => MSA_done );

end Behavioral;
