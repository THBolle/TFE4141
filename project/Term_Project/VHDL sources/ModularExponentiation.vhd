

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity ModularExponentiation is
    Port ( M : in STD_LOGIC_VECTOR (127 downto 0);
           E : in STD_LOGIC_VECTOR (127 downto 0);
           N : in STD_LOGIC_VECTOR (127 downto 0);
           DataInReady : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Resetn : in STD_LOGIC;
           ExpDone : out STD_LOGIC;
           C : out STD_LOGIC_VECTOR (127 downto 0));
end ModularExponentiation;

architecture Behavioral of ModularExponentiation is


COMPONENT PISO128to1 
            Port (                           
            DataIn          : in STD_LOGIC_VECTOR (127 downto 0);
            Enable          : in STD_LOGIC;
            Shift_load      : in STD_LOGIC;
            Clk             : in STD_LOGIC;
            Resetn          : in STD_LOGIC;
            DataOut         : out STD_LOGIC;
            RegEmpty        : out STD_LOGIC
            );
end COMPONENT;

COMPONENT dataRegister 
            Port ( 
            DataIn          : in  STD_LOGIC_VECTOR (127 downto 0);
            Load_enable     : in  STD_LOGIC;
            DataOut         : out STD_LOGIC_VECTOR (127 downto 0);
            Clk             : in  STD_LOGIC;
            Resetn          : in  STD_LOGIC
            );
end COMPONENT;

COMPONENT MUX_2x128in_128Out  
            Port ( 
            InA             : in  STD_LOGIC_VECTOR (127 downto 0);
            InB             : in  STD_LOGIC_VECTOR (127 downto 0);
            Sel             : in  STD_LOGIC;
            OutA            : out STD_LOGIC_VECTOR (127 downto 0)
            );
end COMPONENT; 

COMPONENT modMult
            Generic ( width : integer ); 
            Port ( 
            A        : in  STD_LOGIC_VECTOR(width-1 downto 0 );
            B        : in  STD_LOGIC_VECTOR(width-1 downto 0 );
            n        : in  STD_LOGIC_VECTOR(width-1 downto 0 );
            rst_n    : in  STD_LOGIC;
            start    : in  STD_LOGIC;
            clk      : in  STD_LOGIC;
            C        : out STD_LOGIC_VECTOR(127 downto 0 );
            finished : out STD_LOGIC
            );
end COMPONENT;     

COMPONENT ModExp_stateMachine 
            port ( 
            Clk                : in STD_LOGIC;
            Resetn             : in STD_LOGIC;   
            DataReady          : in STD_LOGIC;
            E_LSB              : in STD_LOGIC;
            Done_MPow2         : in STD_LOGIC;
            Done_MC            : in STD_LOGIC;
            Start_Mpow2        : out STD_LOGIC;
            Start_MC           : out STD_LOGIC;
            Load_data          : out STD_LOGIC;
            exp_done           : out STD_LOGIC;
            shift_load_E       : out STD_LOGIC;
            M_input_source_sel : out STD_LOGIC;
            E_empty            : in STD_LOGIC
            );
end COMPONENT;                                                   


-- --  register signals -- --
 
signal M_reg_output     : STD_LOGIC_VECTOR ( 127 downto 0 );
signal M_reg_input      : STD_LOGIC_VECTOR ( 127 downto 0 );

signal C_reg_output     : STD_LOGIC_VECTOR ( 127 downto 0 );
signal C_reg_input      : STD_LOGIC_VECTOR ( 127 downto 0 );



-- -- Constants -- -- 

-- Note: C_reg_startValue declaration is wrapped 
-- due to page width restrictions
constant C_reg_startVal : STD_LOGIC_VECTOR ( 127 downto 0 ) 
                        := x"00000000000000000000000000000001";


-- -- multiplier signals -- -- 
-- Multiplier 1 calculates M^2
-- Multiplier 2 calculates M*C

signal Mult1_result_MtimesM         : STD_LOGIC_VECTOR ( 127 downto 0 );
signal Mult1_start                  : STD_LOGIC;
signal Mult1_done                   : STD_LOGIC;

signal Mult2_result_MtimesC         : STD_LOGIC_VECTOR ( 127 downto 0 );
signal Mult2_start                  : STD_LOGIC;
signal Mult2_done                   : STD_LOGIC;

-- --  E shifter signals -- -- 
signal E_LSB                        : STD_LOGIC;
signal E_shift_load                 : STD_LOGIC; -- 1 = shift, 0 = load
signal E_shift_load_enable          : STD_LOGIC;
signal E_empty                      : STD_LOGIC;

-- multicast control signals
signal load_data                : STD_LOGIC;


-- -- mux signals -- -- 
-- source select for M register. 1 = Mult 1 output, 0 = Input port
-- source select for C register. 1 = Mult 2 output, 0 = Default value; 
signal reg_input_source_sel       : STD_LOGIC;  


-- system constants
constant multiplier_width : integer := 128;


begin
 -- data path
M_reg : dataRegister            
                PORT MAP ( 
                DataIn => M_reg_input ,             Load_enable => load_data, 
                Clk=> Clk,  Resetn => Resetn ,      DataOut => M_reg_output);
                                                            
C_reg : dataRegister            
                PORT MAP ( 
                DataIn =>  C_reg_input,             Load_enable => load_data, 
                Clk => Clk,   Resetn => Resetn,     DataOut => C_reg_output   );
                            
M_IN_MUX : MUX_2x128in_128Out    
                PORT MAP ( 
                InA => M ,                          Inb => Mult1_result_MtimesM , 
                Sel => reg_input_source_sel,        OutA => M_reg_input );
                
C_IN_MUX : MUX_2x128in_128Out    
                PORT MAP ( 
                InA => C_reg_startVal,              Inb => Mult2_result_MtimesC,
                Sel => reg_input_source_sel,        OutA => C_reg_input);
                                            
E_reg : PISO128to1               
                PORT MAP ( 
                DataIn => E ,                       Enable => load_data , 
                Shift_load => E_shift_load,         Clk => Clk, 
                Resetn => Resetn,                   DataOut => E_LSB,
                RegEmpty => E_empty  );
                
                                            
-- multiplier one                           
Multiplier1 : modMult           
                GENERIC MAP ( multiplier_width ) 
                PORT MAP (  
                A => M_reg_output,                  B => M_reg_output,
                N => N,                             rst_n => Resetn,        
                Clk => Clk,                         start => Mult1_start,
                finished =>  Mult1_done,            C => Mult1_result_MtimesM);
                 
-- multiplier two
Multiplier2 : modMult           
                GENERIC MAP ( multiplier_width )
                PORT MAP (  
                A => M_reg_output,                  B => C_reg_output,
                N => N,                             rst_n => Resetn,
                Clk => Clk,                         start => Mult2_start,
                finished => Mult2_done,             C => Mult2_result_MtimesC );

-- control path
FSM : ModExp_stateMachine       
                PORT MAP ( 
                DataReady => DataInReady,           E_LSB => E_Lsb, 
                Done_MPow2 => Mult1_done,           Done_MC => Mult2_done,
                Clk => Clk,                         Resetn => Resetn,
                Start_Mpow2 => Mult1_start,         Start_MC => Mult2_start,
                Load_data => load_data,             exp_done => ExpDone,
                shift_load_E => E_shift_load,       E_empty => E_empty,
                M_input_source_sel => reg_input_source_sel    
               );


-- -- combinatorial mapping from internal signal to output -- --
C (127 downto 0 ) <= C_reg_output ( 127 downto 0 );
                                              
end Behavioral;
