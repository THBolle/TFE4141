library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modMultShiftReg is
    Generic ( width : positive := 128 );
    Port ( dataIn : in STD_LOGIC_VECTOR (width-1 downto 0);
           clk, rst_n, write, shift : in STD_LOGIC;
           MSB : out STD_LOGIC);
end modMultShiftReg;

architecture Behavioral of modMultShiftReg is
    signal data : std_logic_vector (width-1 downto 0);
begin
    process (clk, rst_n, write, shift) begin
        if rst_n = '0' then
            data <= (others => '0');
        elsif rising_edge(clk) then
            if write = '1' then
                data <= dataIn;
            else
                data <= data(width-2 downto 0) & data(width-1);
            end if;
        end if;
    end process;
    
    MSB <= data(width-1);
    
end Behavioral;