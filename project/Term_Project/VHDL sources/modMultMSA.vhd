library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL; -- (not IEEE)
use IEEE.NUMERIC_STD.ALL;
--use UNISIM.VComponents.all;

entity modMultMSA is
    Generic ( width : positive := 128 );
    Port ( A, B, n : in STD_LOGIC_VECTOR (width-1 downto 0);
           clk, rst_n, reset_C, MSAL_run, B_bit : in STD_LOGIC;
           C : out STD_LOGIC_VECTOR (width-1 downto 0) );
end modMultMSA;

architecture Behavioral of modMultMSA is
    signal C_conv : std_logic_vector (width + 2 downto 0);
    signal P : signed (width+2 downto 0);
    signal P_sa : signed (width+2 downto 0);
    signal P_sub_n : signed (width+2 downto 0);
    signal P_sub_2n : signed (width+2 downto 0);
begin
    
    P_sa <= signed('0' & P(width downto 0) & '0') + signed('0' & (A and (A'range => B_bit)));
    P_sub_n <= P_sa - signed('0' & n);
    P_sub_2n <= P_sa - signed('0' & n(width-1 downto 0) & '0');
    
    process (rst_n, reset_C, clk)
    begin
        if rst_n = '0' or reset_C = '1' then
            P <= (others => '0');
        elsif rising_edge(clk) then
            if MSAL_run = '1' then
                if P_sub_2n(width+2) = '0' then
                    P <= P_sub_2n;
                elsif P_sub_n(width+2) = '0' then
                    P <= P_sub_n;
                else
                    P <= P_sa;
                end if;
            end if;
        end if;
    end process;
    
    C_conv <= std_logic_vector(P);
    C <= C_conv(width - 1 downto 0);
    

end Behavioral;
