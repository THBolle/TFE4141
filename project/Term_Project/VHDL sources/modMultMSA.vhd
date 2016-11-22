library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity modMultMSA is
    Generic ( width : positive := 128 );
    Port ( A, n : in STD_LOGIC_VECTOR (width-1 downto 0);
           clk, rst_n, reset_C, MSAL_run, B_bit : in STD_LOGIC;
           C : out STD_LOGIC_VECTOR (width-1 downto 0) );
end modMultMSA;

architecture Behavioral of modMultMSA is
    signal P : signed (width-1 downto 0);
    signal P_sa, P_sub_n, P_sub_2n : signed (width+2 downto 0);
    signal P_sub_n_b, P_sub_2n_b : std_logic_vector (width+2 downto 0);
    signal msb_state : std_logic_vector (1 downto 0);
begin
    
    -- SHIFT ADD--
    P_sa <= signed("00" & P & '0') + signed("000" & (A and (A'range => B_bit)));
    
    -- SUBTRACT --
    P_sub_n <= P_sa - signed("000" & n);
    P_sub_2n <= P_sa - signed("00" & n & '0');
    
    -- FETCH MSB --
    P_sub_n_b <= std_logic_vector(P_sub_n);
    P_sub_2n_b <= std_logic_vector(P_sub_2n);
    msb_state <= P_sub_2n_b(width+2) & P_sub_n_b(width+2); --MSBs
    
    process (rst_n, reset_C, clk)
    begin
        if rst_n = '0' or reset_C = '1' then
            P <= (others => '0');
        elsif rising_edge(clk) then
            if MSAL_run = '1' then
                case msb_state is
                    when "11" => P <= P_sa(width-1 downto 0);
                    when "10" => P <= P_sub_n(width-1 downto 0);
                    when others => P <= P_sub_2n(width-1 downto 0);
                end case;
            end if;
        end if;
    end process;
    
    -- OUTPUT --
    C <= std_logic_vector(P);
    
end Behavioral;
