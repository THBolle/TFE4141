library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
--use UNISIM.VComponents.all;

entity modMultMSA is
    Generic ( width : positive := 128 );
    Port ( A, B, n : in STD_LOGIC_VECTOR (width-1 downto 0);
           clk, rst_n, reset_C, MSAL_run : in STD_LOGIC;
           B_index : in natural;
           C : out STD_LOGIC_VECTOR (width-1 downto 0) );
end modMultMSA;

architecture Behavioral of modMultMSA is
    signal P : STD_LOGIC_VECTOR (width+1 downto 0);
    signal P_sa : STD_LOGIC_VECTOR (width+1 downto 0);
    signal P_sub_n : STD_LOGIC_VECTOR (width+1 downto 0);
    signal P_sub_2n : STD_LOGIC_VECTOR (width+1 downto 0);
begin
    
    P_sa <= P(width downto 0) & '0' + (A and (A'range => B(B_index)));
    P_sub_n <= P_sa - n;
    P_sub_2n <= P_sub_n - n;
    
    process (rst_n, reset_C, clk)
    begin
        if rst_n = '0' or reset_C = '1' then
            P <= (others => '0');
        elsif rising_edge(clk) then
            if MSAL_run = '1' then
                if P_sa < n then
                    P <= P_sa;
                elsif P_sub_n < n then
                    P <= P_sub_n;
                else
                    P <= P_sub_2n;
                end if;
            end if;
        end if;
    end process;
    
    C <= P (width-1 downto 0);

end Behavioral;
