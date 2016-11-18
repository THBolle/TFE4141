library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
--use UNISIM.VComponents.all;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shiftOut is
    Port ( clk, rst_n, startShiftOut    : in  STD_LOGIC;
           M                            : in  STD_LOGIC_VECTOR (127 downto 0);
           DataShiftComplete            : out STD_LOGIC;
           DataOut                      : out STD_LOGIC_VECTOR (31 downto 0));
end shiftOut;

architecture Behavioral of shiftOut is
    signal cnt : unsigned (1 downto 0);
    
    type SHIFT_STATE is ( IDLE, SHIFTING, DONE  );
    
    signal state : SHIFT_STATE; 
    
begin

    process (clk, rst_n, startShiftOut)
    begin
        if rst_n = '0' then
            state <= IDLE;
            cnt <= to_unsigned(0,2);
        elsif rising_edge(clk) then
           
            
            case state is
                when IDLE =>
                    if ( startShiftOut = '1') then
                        state <= SHIFTING;
                    else 
                        state <= IDLE;
                    end if;
                    
                    cnt <= cnt;
                
                when SHIFTING => 
                    
                    if ( cnt = to_unsigned(3,2)) then
                        state <= DONE;
                    else 
                        state <= SHIFTING;
                    end if;   
                    
                    cnt <= cnt + 1;
                    
                when done => 
                    cnt <= to_unsigned(0,2);
                    state <= IDLE; 
            end case;
        end if;
    end process;
    
    with cnt select
    DataOut ( 31 downto 0 ) <=  M(31 downto 0) when "00",
                                M(63 downto 32) when "01",
                                M(95 downto 64) when "10",
                                M(127 downto 96) when "11",
                                x"00000000" when others;

    DatashiftComplete <= '1' when state = DONE else '0';

--    process (startShiftOut, cnt) begin
--        case startShiftOut & cnt is
--            when "11" => DataOut <= M(127 downto 96);
--            when "10" => DataOut <= M(95 downto 64);
--            when "01" => DataOut <= M(63 downto 32);
--            when "00" => DataOut <= M(31 downto 0);
--            when others => DataOut <= (others => '0');
--        end case;
--    end process;
    
end Behavioral;