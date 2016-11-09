library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--use UNISIM.VComponents.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_out is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           M : in STD_LOGIC_VECTOR (127 downto 0);
           StartShiftOut : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (31 downto 0));
end shift_out;

architecture Behavioral of shift_out is
signal cnt : std_logic_vector(1 downto 0); --grey code
begin

    process (Clk, StartShiftOut) begin
        if reset = '1' then
            cnt <= "00";
        end if;
        if rising_edge(clk) and reset = '0' then
            if cnt = "00" and StartShiftOut = '1' then
                cnt = cnt + 1;
            else
                cnt = cnt + 1;
            end if;
        end if;
    end process;
    
    if reset = '0' then
        case cnt is
            when 0 => DataOut <= M(31 downto 0);
            when 1 => DataOut <= M(63 downto 32);
            when 2 => DataOut <= M(95 downto 64);
            when 3 => DataOut <= M(127 downto 96);
        end case;
    end if;
    
end Behavioral;
