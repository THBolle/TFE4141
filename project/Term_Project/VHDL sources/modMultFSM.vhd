library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modMultFSM is
    Generic ( width : natural );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           MSA_done : in STD_LOGIC;
           rst_MSA : out STD_LOGIC;
           finished : out STD_LOGIC);
end modMultFSM;

architecture Behavioral of modMultFSM is
    type FSM_state is (IDLE, INIT, MSA, DONE);
    signal state : FSM_state;
begin
    stateSeqv: process(rst, clk) begin
        if rst = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            case state is
            when IDLE =>
                if start = '1' then
                    state <= INIT;
                else
                    state <= IDLE;
                end if;
            when INIT => state <= MSA;
            when MSA =>
                if MSA_done = '1' then
                    state <= DONE;
                else
                    state <= MSA;
                end if;
            when DONE => state <= IDLE;
            end case;
        end if;
    end process stateSeqv;
    
    rst_MSA <= '1' when state = INIT else '0';
    finished <= '1' when state = DONE else '0';

end Behavioral;
