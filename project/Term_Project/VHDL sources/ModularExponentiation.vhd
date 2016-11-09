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
COMPONENT PISO128to1 Port ( 
                                    DataIn : in STD_LOGIC_VECTOR (127 downto 0);
                                    Enable : in STD_LOGIC;
                                    Shift_load : in STD_LOGIC;
                                    Clk : in STD_LOGIC;
                                    Resetn : in STD_LOGIC;
                                    DataOut : out STD_LOGIC);
end COMPONENT;

COMPONENT dataRegister Port ( 
                                    DataIn       : in STD_LOGIC_VECTOR (127 downto 0);
                                    Load_enable  : in STD_LOGIC;
                                    DataOut      : out STD_LOGIC_VECTOR (127 downto 0);
                                    Clk          : in STD_LOGIC;
                                    Resetn       : in STD_LOGIC
                            );
end COMPONENT;

COMPONENT MUX_2x128in_128Out  Port ( 
                                            InA : in STD_LOGIC_VECTOR (127 downto 0);
                                            InB : in STD_LOGIC_VECTOR (127 downto 0);
                                            Sel : in STD_LOGIC;
                                            OutA : out STD_LOGIC_VECTOR (127 downto 0)
                                      );
end COMPONENT; 

COMPONENT MULTIPLIER Port ( 
                            X : in  STD_LOGIC_VECTOR(127 downto 0 );
                            Y : in  STD_LOGIC_VECTOR(127 downto 0 );
                            Start : in STD_LOGIC;
                            Clk : in STD_LOGIC;
                            Z : out STD_LOGIC_VECTOR(127 downto 0 );
                            Done : out STD_LOGIC
                          );
end COMPONENT;                                                        

--internal signals
signal M_Output : STD_LOGIC_VECTOR ( 127 downto 0 );
signal M_Input  : STD_LOGIC_VECTOR ( 127 downto 0 );
signal M_pow2   : STD_LOGIC_VECTOR ( 127 downto 0 );
signal M_times_C : STD_LOGIC_VECTOR ( 127 downto 0 );
signal C_out : STD_LOGIC_VECTOR ( 127 downto 0 );
signal E_Lsb    : STD_LOGIC;
signal M_source_sel : STD_LOGIC;
signal M_load : STD_LOGIC;
signal M_times_C_load : STD_LOGIC;
signal E_enable : STD_LOGIC;
signal E_shift_load : STD_LOGIC;



begin
 -- data path
M_reg : dataRegister PORT MAP (DataIn => M_Input, Load_enable => M_load, Clk=> Clk, Resetn => Resetn ,DataOut => M_Output);
C_reg : dataRegister PORT MAP ( DataIn => M_times_C, Load_enable => M_load, DataOut => C , Clk => Clk, Resetn => Resetn  );
M_INPUT_MUX : MUX_2x128in_128Out PORT MAP (InA => M_pow2 , Inb => M, Sel => M_source_sel, OutA => M_Input );
E_reg : PISO128to1 PORT MAP (DataIn => E , Enable => E_enable , Shift_load => E_shift_load, Clk => Clk,Resetn=>Resetn, DataOut => E_Lsb  );
-- multiplier one
-- multiplier two

-- control path
-- state machine




end Behavioral;
