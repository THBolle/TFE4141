----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2016 02:33:20 PM
-- Design Name: 
-- Module Name: ModularExponentiation - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ModularExponentiation is
    Port ( M : in STD_LOGIC_VECTOR (127 downto 0);
           E : in STD_LOGIC_VECTOR (127 downto 0);
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
            DataOut         : out STD_LOGIC
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

COMPONENT MULTIPLIER 
            Port ( 
            X : in  STD_LOGIC_VECTOR(127 downto 0 );
            Y : in  STD_LOGIC_VECTOR(127 downto 0 );
            Start : in STD_LOGIC;
            Clk : in STD_LOGIC;
            Z : out STD_LOGIC_VECTOR(127 downto 0 );
            Done : out STD_LOGIC
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
            M_input_source_sel : out STD_LOGIC
            );
end COMPONENT;                                                   


-- --  register signals -- -- 
signal M_reg_output     : STD_LOGIC_VECTOR ( 127 downto 0 );
signal M_reg_input      : STD_LOGIC_VECTOR ( 127 downto 0 );

signal C_reg_output     : STD_LOGIC_VECTOR ( 127 downto 0 );
signal C_reg_input      : STD_LOGIC_VECTOR ( 127 downto 0 );

-- -- multiplier signals -- -- 
-- Multiplier 1 calculates M^2
-- Multiplier 2 calculates M*C

signal Mult1_result_MtimesM         : STD_LOGIC_VECTOR ( 127 downto 0 );
signal Mult1_inputX                 : STD_LOGIC_VECTOR ( 127 downto 0 );
signal Mult1_inputY                 : STD_LOGIC_VECTOR ( 127 downto 0 );  
signal Mult1_start                  : STD_LOGIC;
signal Mult1_done                   : STD_LOGIC;

signal Mult2_result_MtimesC         : STD_LOGIC_VECTOR ( 127 downto 0 );
signal Mult2_start                  : STD_LOGIC;
signal Mult2_done                   : STD_LOGIC;

-- --  E shifter signals -- -- 
signal E_LSB                        : STD_LOGIC;
signal E_shift_load                 : STD_LOGIC; -- 1 = shift, 0 = load
signal E_shift_load_enable          : STD_LOGIC;


-- multicast control signals
signal load_data                : STD_LOGIC;


-- -- M input demux signals -- -- 
signal M_reg_input_source_sel       : STD_LOGIC; -- source select for M register. 1 = Mult 1 output, 0 = Input port



begin
 -- data path
M_reg : dataRegister             PORT MAP ( DataIn => M_reg_input ,             Load_enable => load_data, 
                                            Clk=> Clk,  Resetn => Resetn ,      DataOut => M_reg_output);
                                            
C_reg : dataRegister             PORT MAP ( DataIn => Mult2_result_MtimesC,     Load_enable => load_data, 
                                            Clk => Clk,   Resetn => Resetn,     DataOut => C_reg_output   );
                                            
M_IN_MUX : MUX_2x128in_128Out    PORT MAP ( InA => M ,                          Inb => Mult1_result_MtimesM , 
                                            Sel => M_reg_input_source_sel,      OutA => M_reg_input );
                                            
E_reg : PISO128to1               PORT MAP ( DataIn => E ,                       Enable => load_data , 
                                            Shift_load => E_shift_load,         Clk => Clk, 
                                            Resetn => Resetn,                   DataOut => E_LSB  );
                                            
                                            
-- multiplier one
-- multiplier two

-- control path
FSM : ModExp_stateMachine       PORT MAP ( DataReady => DataInReady,            E_LSB => E_Lsb, 
                                                Done_MPow2 => Mult1_done,       Done_MC => Mult2_done,
                                                Clk => Clk,                     Resetn => Resetn,
                                                Start_Mpow2 => Mult1_start,     Start_MC => Mult2_start,
                                                Load_data => load_data,         exp_done => ExpDone,
                                                shift_load_E => E_shift_load,   M_input_source_sel => M_reg_input_source_sel    
                                                );


                                              




end Behavioral;
