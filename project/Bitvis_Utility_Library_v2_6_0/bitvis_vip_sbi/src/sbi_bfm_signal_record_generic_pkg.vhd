--========================================================================================================================
-- Copyright (c) 2015 by Bitvis AS.  All rights reserved.
-- A free license is hereby granted, free of charge, to any person obtaining
-- a copy of this VHDL code and associated documentation files (for 'Bitvis Utility Library'),
-- to use, copy, modify, merge, publish and/or distribute - subject to the following conditions:
--  - This copyright notice shall be included as is in all copies or substantial portions of the code and documentation
--  - The files included in Bitvis Utility Library may only be used as a part of this library as a whole
--  - The License file may not be modified
--  - The calls in the code to the license file ('show_license') may not be removed or modified.
--  - No other conditions whatsoever may be added to those of this License

-- BITVIS UTILITY LIBRARY AND ANY PART THEREOF ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-- WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH BITVIS UTILITY LIBRARY.
--========================================================================================================================

------------------------------------------------------------------------------------------
-- VHDL unit     : Bitvis VIP SBI Library : sbi_bfm_signal_record_pkg
--
-- Description   : See library quick reference (under 'doc') and README-file(s)
------------------------------------------------------------------------------------------

-- *******************************************************************************************
--
-- Example of wrapper around this generic package width address width 32 and data width 16.
-- This needs to be in the very top of e.g. a test bench file, before all other library
-- and use clauses.
-- 
-- package sbi_bfm_signal_record_a32_d16_pkg is new bitvis_vip_sbi.sbi_bfm_signal_record_pkg
--    generic map(GC_SBI_ADDR_WIDTH <= 32,
--                GC_SBI_DATA_WIDTH <= 16);
-- 
-- use work.sbi_bfm_signal_record_a32_d16_pkg.all;
--
-- *******************************************************************************************
               
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library bitvis_util;
use bitvis_util.types_pkg.all;
use bitvis_util.string_methods_pkg.all;
use bitvis_util.adaptations_pkg.all;
use bitvis_util.methods_pkg.all;
use bitvis_util.bfm_common_pkg.all;

library bitvis_vip_sbi;
use bitvis_vip_sbi.sbi_bfm_pkg.all;

--=================================================================================================

package sbi_bfm_signal_record_generic_pkg is
  generic (GC_SBI_ADDR_WIDTH : natural;
           GC_SBI_DATA_WIDTH : natural);
           
  ----------------------------------------------------
  -- Types for SBI BFMs
  ----------------------------------------------------

  constant C_SCOPE : string := "SBI BFM";

  -- Put ports between BFM and DUT in records:
  type t_sbi_io is record
    cs         : std_logic;
    addr       : unsigned(GC_SBI_ADDR_WIDTH - 1 downto 0);
    rd         : std_logic;
    wr         : std_logic;
    din        : std_logic_vector(GC_SBI_DATA_WIDTH - 1 downto 0);
    rdy        : std_logic;
    dout       : std_logic_vector(GC_SBI_DATA_WIDTH - 1 downto 0);
  end record;

  constant C_SBI_IO_DEFAULT : t_sbi_io := (
    cs    => '0',
    rd    => '0',
    wr    => '0',
    addr  => (others => '0'),
    din   => (others => '0'),
    rdy   => 'Z',            -- Output port set passive.
    dout  => (others => 'Z') -- Output port set passive.
  );

  ----------------------------------------------------
  -- BFM procedures
  ----------------------------------------------------
  procedure sbi_write (
    constant addr_value    : in unsigned;
    constant data_value    : in std_logic_vector;
    constant msg           : in string;
    signal   clk           : in std_logic;
    signal   sbi_io        : inout t_sbi_io;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
    );

  ---------------------------------------------------------------------------------
  -- read()
  ---------------------------------------------------------------------------------
  -- Perform a read operation and return the result
  procedure sbi_read (
    constant addr_value    : in unsigned;
    variable data_value    : out std_logic_vector;
    constant msg           : in string;
    signal   clk           : in std_logic;
    signal   sbi_io        : inout t_sbi_io;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT;
    constant proc_name     : in string  := "sbi_read"  -- overwrite if called from other procedure like sbi_check
  );


  procedure sbi_check (
    constant addr_value    : in unsigned;
    constant data_exp      : in std_logic_vector;
    constant alert_level   : in t_alert_level := ERROR;
    constant msg           : in string;
    signal   clk           : in std_logic;
    signal   sbi_io        : inout t_sbi_io;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
    );

end package sbi_bfm_signal_record_generic_pkg;


--=================================================================================================
--=================================================================================================

package body sbi_bfm_signal_record_generic_pkg is

  ---------------------------------------------------------------------------------
  -- write
  ---------------------------------------------------------------------------------
  procedure sbi_write (
    constant addr_value    : in unsigned;
    constant data_value    : in std_logic_vector;
    constant msg           : in string;
    signal   clk           : in std_logic;
    signal   sbi_io        : inout t_sbi_io;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
  ) is
  begin
    sbi_write(addr_value, data_value, msg, clk, sbi_io.cs, sbi_io.addr, 
              sbi_io.rd, sbi_io.wr, sbi_io.rdy, sbi_io.din, 
              clk_period, scope, msg_id_panel, config);
  end procedure;

  ---------------------------------------------------------------------------------
  -- read()
  ---------------------------------------------------------------------------------
  -- Perform a read operation and return the result
  procedure sbi_read (
    constant addr_value    : in unsigned;
    variable data_value    : out std_logic_vector;
    constant msg           : in string;
    signal   clk           : in std_logic;
    signal   sbi_io        : inout t_sbi_io;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT;
    constant proc_name     : in string  := "sbi_read"  -- overwrite if called from other procedure like sbi_check
  ) is
  begin
    sbi_read(addr_value, data_value, msg, clk, sbi_io.cs, sbi_io.addr, 
             sbi_io.rd, sbi_io.wr, sbi_io.rdy, sbi_io.dout, 
             clk_period, scope, msg_id_panel, config, proc_name);
  end procedure;

  ---------------------------------------------------------------------------------
  -- check()
  ---------------------------------------------------------------------------------
  -- Perform a read operation, then compare the read value to the expected value.
  procedure sbi_check (
    constant addr_value    : in unsigned;
    constant data_exp      : in std_logic_vector;
    constant alert_level   : in t_alert_level := ERROR;
    constant msg           : in string;
    signal   clk           : in std_logic;
    signal   sbi_io        : inout t_sbi_io;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
  ) is
  begin
    sbi_check(addr_value, data_exp, alert_level, msg, clk, sbi_io.cs, sbi_io.addr, 
              sbi_io.rd, sbi_io.wr, sbi_io.rdy, sbi_io.dout, 
              clk_period, scope, msg_id_panel, config);
  end procedure;

end package body sbi_bfm_signal_record_generic_pkg;