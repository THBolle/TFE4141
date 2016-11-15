library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
--use UNISIM.VComponents.all;

entity modMultMSA is
    Generic ( width : natural );
    Port ( A : in STD_LOGIC_VECTOR (width-1 downto 0);
           B : in STD_LOGIC_VECTOR (width-1 downto 0);
           n : in STD_LOGIC_VECTOR (width-1 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           C : out STD_LOGIC_VECTOR (width-1 downto 0);
           MSA_done : out STD_LOGIC);
end modMultMSA;

architecture Behavioral of modMultMSA is
    signal cnt : integer range -1 to width;
    signal P : STD_LOGIC_VECTOR (width+1 downto 0);
begin

    process (rst) begin
        
    end process;
    
    process (rst, clk)
        variable P_sa : STD_LOGIC_VECTOR (width+1 downto 0);
        variable P_mod1 : STD_LOGIC_VECTOR (width+1 downto 0);
        variable P_mod2 : STD_LOGIC_VECTOR (width+1 downto 0);
    begin
        if rst = '1' then
            MSA_done <= '0';
            cnt <= width - 1;
            P <= (others => '0');
        elsif cnt = -1 then null;
        elsif rising_edge(clk) then
            P_sa := P(width downto 0) & '0' + (A and (A'range => B(cnt)));
            if P_sa > n then
                P_mod1 := P_sa - n;
            else
                P_mod1 := P_sa;
            end if;
            if P_mod1 > n then
                P_mod2 := P_mod1 - n;
            else
                P_mod2 := P_mod1;
            end if;
            cnt <= cnt - 1;
            P <= P_mod2; 
        end if;
        if cnt = - 1 then
            MSA_done <= '1';
        else
            MSA_done <= '0';
        end if;
    end process;
    
    C <= P (width-1 downto 0);

end Behavioral;
