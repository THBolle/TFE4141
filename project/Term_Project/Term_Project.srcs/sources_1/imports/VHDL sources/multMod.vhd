library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity multMod is
    generic ( width         : integer := 8 );
    port (  clk, rst, run   : in STD_LOGIC;
            finished        : out STD_LOGIC;
            A, B, N         : in STD_LOGIC_VECTOR (width-1 downto 0);
            C               : out STD_LOGIC_VECTOR (width-1 downto 0));
end multMod;

architecture behav of multMod is
    type state is (IDLE, INIT, MULT, MODU, DONE);
    attribute enum_encoding : string;
    attribute enum_encoding of state : type is "000 001 010 011 111";
    signal curr_state, next_state : state;
    signal P : std_logic_vector(2*width-1 downto 0); --may be substituted with a shift register
    signal cnt : natural range 0 to width-1;
    signal multDone : boolean;
begin
    
    C <= P(width-1 downto 0);

    CombFSM : process(P, multDone, run, curr_state)
    begin
        finished <= '0';
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
                if multDone then
                    next_state <= DONE;
                else
                    next_state <= MULT;
                end if;
            end if;
        when MODU =>
            if P >= n then
                next_state <= MODU;
            else
                if multDone then
                    next_state <= DONE;
                else
                    next_state <= MULT;
                end if;
            end if;
        when DONE =>
            finished <= '1';
            if run = '1' then
                next_state <= IDLE;
            else
                next_state <= IDLE;
            end if;
        when others => null;
        end case;
    end process CombFSM;
    
    SyncFSM : process(rst, clk) begin
        if rst = '1' then
            curr_state <= IDLE;
        elsif rising_edge(clk) then
            curr_state <= next_state;
        end if;
    end process syncFSM;
    
    StateSeqv : process(curr_state)
    begin
--        if rising_edge(clk) then
--            case curr_state is
--            when INIT =>
--                P <= (others => '0');
--                cnt <= width - 1;
--            when MULT =>
--                P <= P(2*width-2 downto 0) & '0' + (A and (A'range => B(cnt)));
--                if (cnt > 0) then
--                    cnt <= cnt - 1;
--                    multDone <= false;
--                else
--                    multDone <= true;
--                end if;
--            when MODU =>
--                P <= P - n;
--            when others => null;
--            end case;
--        end if;
        
    end process StateSeqv;
    
end behav;

