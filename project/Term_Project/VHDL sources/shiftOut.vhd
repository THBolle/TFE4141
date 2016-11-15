library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
--use IEEE.NUMERIC_STD.ALL;
--use UNISIM.VComponents.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shiftOut is
    Port ( clk, rst_n, startShiftOut    : in  STD_LOGIC;
           M                            : in  STD_LOGIC_VECTOR (127 downto 0);
           DataOut                      : out STD_LOGIC_VECTOR (31 downto 0));
end shiftOut;

architecture Behavioral of shiftOut is
    signal cnt : std_logic_vector(1 downto 0);
begin

    process (clk, startShiftOut)
    begin
        if rst_n = '0' then
            cnt <= "00";
        elsif rising_edge(clk) and startShiftOut = '1' then
            if cnt = "00" then
                cnt <= "11";
            else
                cnt <= cnt - 1;
            end if;
        end if;
    end process;

    process (startShiftOut, cnt) begin
        case startShiftOut & cnt is
            when "111" => DataOut <= M(127 downto 96);
            when "110" => DataOut <= M(95 downto 64);
            when "101" => DataOut <= M(63 downto 32);
            when "100" => DataOut <= M(31 downto 0);
            when others => DataOut <= (others => '0');
        end case;
    end process;
    
end Behavioral;