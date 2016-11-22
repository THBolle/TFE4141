library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity modMultFSM is
    Generic ( width : natural := 128 );
    Port ( clk, rst_n, start : in STD_LOGIC;
           reset_C, MSAL_run, finished : out STD_LOGIC );
end modMultFSM;

architecture Behavioral of modMultFSM is
    type FSM_state is (IDLE, C_RST, LOOPING, C_RDY);
    signal state : FSM_state;
    attribute fsm_encoding : string;
    attribute fsm_encoding of state : signal is "gray";
    signal cnt : natural range 0 to width-1;
begin
    stateSeqv: process(rst_n, clk)
    begin
        if rst_n = '0' then
            state <= IDLE;
            cnt <= 0;
        elsif rising_edge(clk) then
            case state is
            when IDLE =>
                if start = '1' then
                    cnt <= width-1;
                    state <= C_RST;
                end if;
            when C_RST =>
                state <= LOOPING;
            when LOOPING =>
                if cnt > 0 then
                    cnt <= cnt - 1;
                else
                    state <= C_RDY;
                end if;
            when C_RDY =>
                if start = '1' then
                    state <= C_RST;
                else
                    state <= IDLE;
                end if;
            end case;
        end if;
    end process stateSeqv;
    
    reset_C <= '1' when (state = C_RST) else '0';
    MSAL_run <= '1' when (state = LOOPING) else '0';
    finished <= '1' when (state = C_RDY) else '0';
    

end Behavioral;
