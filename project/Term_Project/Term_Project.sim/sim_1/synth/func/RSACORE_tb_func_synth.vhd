-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Mon Nov 07 17:40:48 2016
-- Host        : Capacitor running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Kristian/GitHub/TFE4141/project/Term_Project/Term_Project.sim/sim_1/synth/func/RSACORE_tb_func_synth.vhd
-- Design      : RSACore
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity EdgeCounter is
  port (
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC;
    AR : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end EdgeCounter;

architecture STRUCTURE of EdgeCounter is
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \internalCountVal[2]_i_1_n_0\ : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \internalCountVal[0]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \internalCountVal[1]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \internalCountVal[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \internalCountVal[3]_i_1\ : label is "soft_lutpair0";
begin
  Q(3 downto 0) <= \^q\(3 downto 0);
\internalCountVal[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => plusOp(0)
    );
\internalCountVal[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => plusOp(1)
    );
\internalCountVal[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \internalCountVal[2]_i_1_n_0\
    );
\internalCountVal[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => plusOp(3)
    );
\internalCountVal_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      CLR => AR(0),
      D => plusOp(0),
      Q => \^q\(0)
    );
\internalCountVal_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      CLR => AR(0),
      D => plusOp(1),
      Q => \^q\(1)
    );
\internalCountVal_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      CLR => AR(0),
      D => \internalCountVal[2]_i_1_n_0\,
      Q => \^q\(2)
    );
\internalCountVal_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      CLR => AR(0),
      D => plusOp(3),
      Q => \^q\(3)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity TopLevelStateMachine is
  port (
    CoreFinished_OBUF : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    AR : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    InitRsa_IBUF : in STD_LOGIC;
    StartRsa_IBUF : in STD_LOGIC;
    Resetn_IBUF : in STD_LOGIC;
    CLK : in STD_LOGIC
  );
end TopLevelStateMachine;

architecture STRUCTURE of TopLevelStateMachine is
  signal \FSM/_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[2]_i_2_n_0\ : STD_LOGIC;
  signal state : STD_LOGIC;
  signal \state__0\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \state__0\ : signal is "yes";
  attribute KEEP : string;
  attribute KEEP of \FSM_sequential_state_reg[0]\ : label is "yes";
  attribute KEEP of \FSM_sequential_state_reg[1]\ : label is "yes";
  attribute KEEP of \FSM_sequential_state_reg[2]\ : label is "yes";
begin
CoreFinishedn0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFAB"
    )
        port map (
      I0 => InitRsa_IBUF,
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => StartRsa_IBUF,
      O => CoreFinished_OBUF
    );
CounterEnable0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFABAE"
    )
        port map (
      I0 => StartRsa_IBUF,
      I1 => \state__0\(1),
      I2 => \state__0\(2),
      I3 => \state__0\(0),
      I4 => InitRsa_IBUF,
      O => E(0)
    );
\FSM/\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000004D4D4D48"
    )
        port map (
      I0 => \state__0\(0),
      I1 => state,
      I2 => \state__0\(1),
      I3 => StartRsa_IBUF,
      I4 => InitRsa_IBUF,
      I5 => \state__0\(2),
      O => \FSM/_n_0\
    );
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"000E"
    )
        port map (
      I0 => \state__0\(1),
      I1 => InitRsa_IBUF,
      I2 => \state__0\(2),
      I3 => \state__0\(0),
      O => \FSM_sequential_state[0]_i_1_n_0\
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"000D"
    )
        port map (
      I0 => InitRsa_IBUF,
      I1 => \state__0\(1),
      I2 => \state__0\(2),
      I3 => \state__0\(0),
      O => \FSM_sequential_state[1]_i_1_n_0\
    );
\FSM_sequential_state[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \state__0\(2),
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      O => \FSM_sequential_state[2]_i_1_n_0\
    );
\FSM_sequential_state[2]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Resetn_IBUF,
      O => \FSM_sequential_state[2]_i_2_n_0\
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => \FSM/_n_0\,
      CLR => \FSM_sequential_state[2]_i_2_n_0\,
      D => \FSM_sequential_state[0]_i_1_n_0\,
      Q => \state__0\(0)
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => \FSM/_n_0\,
      CLR => \FSM_sequential_state[2]_i_2_n_0\,
      D => \FSM_sequential_state[1]_i_1_n_0\,
      Q => \state__0\(1)
    );
\FSM_sequential_state_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => \FSM/_n_0\,
      CLR => \FSM_sequential_state[2]_i_2_n_0\,
      D => \FSM_sequential_state[2]_i_1_n_0\,
      Q => \state__0\(2)
    );
\internalCountVal[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFABAEFFFFFFFF"
    )
        port map (
      I0 => InitRsa_IBUF,
      I1 => \state__0\(0),
      I2 => \state__0\(2),
      I3 => \state__0\(1),
      I4 => StartRsa_IBUF,
      I5 => Resetn_IBUF,
      O => AR(0)
    );
\state_inferred__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => Q(3),
      I1 => Q(2),
      I2 => Q(0),
      I3 => Q(1),
      O => state
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity RSACore is
  port (
    Clk : in STD_LOGIC;
    Resetn : in STD_LOGIC;
    InitRsa : in STD_LOGIC;
    StartRsa : in STD_LOGIC;
    DataIn : in STD_LOGIC_VECTOR ( 31 downto 0 );
    DataOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    CoreFinished : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of RSACore : entity is true;
end RSACore;

architecture STRUCTURE of RSACore is
  signal ClkCounterIn : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Clk_IBUF : STD_LOGIC;
  signal Clk_IBUF_BUFG : STD_LOGIC;
  signal CoreFinished_OBUF : STD_LOGIC;
  signal CounterEnable : STD_LOGIC;
  signal FSM_n_2 : STD_LOGIC;
  signal InitRsa_IBUF : STD_LOGIC;
  signal Resetn_IBUF : STD_LOGIC;
  signal StartRsa_IBUF : STD_LOGIC;
begin
Clk_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => Clk_IBUF,
      O => Clk_IBUF_BUFG
    );
Clk_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => Clk,
      O => Clk_IBUF
    );
CoreFinished_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => CoreFinished_OBUF,
      O => CoreFinished
    );
DataInCounter: entity work.EdgeCounter
     port map (
      AR(0) => FSM_n_2,
      CLK => Clk_IBUF_BUFG,
      E(0) => CounterEnable,
      Q(3 downto 0) => ClkCounterIn(3 downto 0)
    );
\DataOut_OBUF[0]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(0),
      T => '1'
    );
\DataOut_OBUF[10]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(10),
      T => '1'
    );
\DataOut_OBUF[11]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(11),
      T => '1'
    );
\DataOut_OBUF[12]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(12),
      T => '1'
    );
\DataOut_OBUF[13]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(13),
      T => '1'
    );
\DataOut_OBUF[14]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(14),
      T => '1'
    );
\DataOut_OBUF[15]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(15),
      T => '1'
    );
\DataOut_OBUF[16]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(16),
      T => '1'
    );
\DataOut_OBUF[17]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(17),
      T => '1'
    );
\DataOut_OBUF[18]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(18),
      T => '1'
    );
\DataOut_OBUF[19]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(19),
      T => '1'
    );
\DataOut_OBUF[1]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(1),
      T => '1'
    );
\DataOut_OBUF[20]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(20),
      T => '1'
    );
\DataOut_OBUF[21]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(21),
      T => '1'
    );
\DataOut_OBUF[22]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(22),
      T => '1'
    );
\DataOut_OBUF[23]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(23),
      T => '1'
    );
\DataOut_OBUF[24]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(24),
      T => '1'
    );
\DataOut_OBUF[25]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(25),
      T => '1'
    );
\DataOut_OBUF[26]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(26),
      T => '1'
    );
\DataOut_OBUF[27]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(27),
      T => '1'
    );
\DataOut_OBUF[28]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(28),
      T => '1'
    );
\DataOut_OBUF[29]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(29),
      T => '1'
    );
\DataOut_OBUF[2]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(2),
      T => '1'
    );
\DataOut_OBUF[30]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(30),
      T => '1'
    );
\DataOut_OBUF[31]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(31),
      T => '1'
    );
\DataOut_OBUF[3]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(3),
      T => '1'
    );
\DataOut_OBUF[4]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(4),
      T => '1'
    );
\DataOut_OBUF[5]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(5),
      T => '1'
    );
\DataOut_OBUF[6]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(6),
      T => '1'
    );
\DataOut_OBUF[7]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(7),
      T => '1'
    );
\DataOut_OBUF[8]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(8),
      T => '1'
    );
\DataOut_OBUF[9]_inst\: unisim.vcomponents.OBUFT
     port map (
      I => '0',
      O => DataOut(9),
      T => '1'
    );
FSM: entity work.TopLevelStateMachine
     port map (
      AR(0) => FSM_n_2,
      CLK => Clk_IBUF_BUFG,
      CoreFinished_OBUF => CoreFinished_OBUF,
      E(0) => CounterEnable,
      InitRsa_IBUF => InitRsa_IBUF,
      Q(3 downto 0) => ClkCounterIn(3 downto 0),
      Resetn_IBUF => Resetn_IBUF,
      StartRsa_IBUF => StartRsa_IBUF
    );
InitRsa_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => InitRsa,
      O => InitRsa_IBUF
    );
Resetn_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => Resetn,
      O => Resetn_IBUF
    );
StartRsa_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => StartRsa,
      O => StartRsa_IBUF
    );
end STRUCTURE;
