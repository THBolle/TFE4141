--Lars

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
--use UNISIM.VComponents.all;

entity multMod is
    port (  clk, rst, run   : in STD_LOGIC;
            finished        : out STD_LOGIC;
            A, B, N         : in STD_LOGIC_VECTOR (127 downto 0);
            --C               : out STD_LOGIC_VECTOR (127 downto 0));
            P               : inout STD_LOGIC_VECTOR (255 downto 0));
end multMod;

architecture rtl of multMod is
    type state is (IDLE, MULT, MODU, DONE);
    signal curr_state, next_state : state;
    --signal P : std_logic_vector(255 downto 0);
    signal cnt : integer range 0 to 127;
begin
    
    --C <= P(127 downto 0); --for testing

    CombFSM : process(cnt, run, curr_state)
    begin
        case curr_state is
        when IDLE =>
            if run = '0' then
                next_state <= IDLE;
            else
                next_state <= MULT;
            end if;
        when MULT =>
            next_state <= MODU;
        when MODU =>
            if cnt = 127 then
                next_state <= DONE;
            else
                next_state <= MULT;
            end if;
        when DONE =>
            if run = '1' then
                next_state <= IDLE;
            else
                next_state <= DONE;
            end if;
        end case;
    end process CombFSM;
    
    NextStateSeqv : process(clk)
    begin
        if rising_edge(clk) then
            case curr_state is
            when IDLE =>
                finished <= '1';
                P <= (others => '0');
                --C <= (others => '0');
                cnt <= 0;
            when MULT =>
                finished <= '0';
                P <= P(254 downto 0) & '0';
                if B(cnt) = '1' then
                    P <= P + A;
                end if;
            when MODU =>
                cnt <= cnt + 1;
                if P > n then
                    P <= P - n;
                end if;
            when DONE =>
                --C <= P(127 downto 0);
            end case;
        end if;
    end process NextStateSeqv;
    
    SyncFSM : process(rst, clk) begin
        --C <= P(127 downto 0); --only for testing
        if rst = '1' then
            curr_state <= IDLE;
        elsif rising_edge(clk) then
            curr_state <= next_state;
        end if;
    end process syncFSM;
end rtl;

