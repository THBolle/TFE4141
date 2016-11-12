library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multMod is
    generic ( width         : integer := 8 );
    port (  clk, rst, run   : in STD_LOGIC;
            busy            : out STD_LOGIC;
            A, B, N         : in STD_LOGIC_VECTOR (width-1 downto 0);
            C               : out STD_LOGIC_VECTOR (width-1 downto 0));
end multMod;

architecture behav of multMod is
    type state is (IDLE, INIT, MULT, MODU, DONE);
    attribute enum_encoding : string;
    attribute enum_encoding of state : type is "000 100 101 110 011";
    signal curr_state, next_state : state;
    signal P : std_logic_vector(2*width-1 downto 0); --may be substituted with a shift register
    signal cnt : natural range 0 to width-1;
    signal busy_reg : std_logic;
begin
    
    C <= P(width-1 downto 0);
    busy <= busy_reg;

    CombFSM : process(P, cnt, run, curr_state)
    begin
        case curr_state is
        when IDLE =>
            if run = '0' then
                next_state <= IDLE;
            else
                next_state <= INIT;
            end if;
        when INIT =>
            next_state <= MULT;
        when MULT =>
            if P >= n then
                next_state <= MODU;
            else
                if cnt > 0 then
                    next_state <= MULT;
                else
                    next_state <= DONE;
                end if;
            end if;
        when MODU =>
            if P >= n then
                next_state <= MODU;
            else
                if cnt > 0 then
                    next_state <= MULT;
                else
                    next_state <= DONE;
                end if;
            end if;
        when DONE =>
            if run = '1' then
                next_state <= IDLE;
            else
                next_state <= DONE;
            end if;
        end case;
    end process CombFSM;
    
    StateSeqv : process(clk)
    begin
        if rising_edge(clk) then
            case curr_state is
            when INIT =>
                busy_reg <= '1';
                P <= (others => '0');
            when MULT =>
                P <= P(2*width-2 downto 0) & '0';
                if B(cnt) = '1' then
                    P <= P + A;
                end if;
            when MODU =>
                P <= P - n;
            when others => busy_reg <= '0';
            end case;
            if next_state = MULT then
                if curr_state > INIT then
                    cnt <= cnt - 1;
                else
                    cnt <= width - 1;
                end if;
            end if;
        end if;
    end process StateSeqv;
    
    SyncFSM : process(rst, clk) begin
        if rst = '1' then
            curr_state <= IDLE;
        elsif rising_edge(clk) then
            curr_state <= next_state;
        end if;
    end process syncFSM;
end behav;
