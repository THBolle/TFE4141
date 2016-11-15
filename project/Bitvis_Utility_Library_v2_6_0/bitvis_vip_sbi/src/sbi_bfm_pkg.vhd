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
-- VHDL unit     : Bitvis VIP SBI Library : sbi_bfm_pkg
--
-- Description   : See library quick reference (under 'doc') and README-file(s)
------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library bitvis_util;
use bitvis_util.types_pkg.all;
use bitvis_util.string_methods_pkg.all;
use bitvis_util.adaptations_pkg.all;
use bitvis_util.methods_pkg.all;
use bitvis_util.bfm_common_pkg.all;

--=================================================================================================
package sbi_bfm_pkg is

  ----------------------------------------------------
  -- Types for SBI BFMs
  ----------------------------------------------------

  constant C_SCOPE : string := "SBI BFM";

  -- Configuration record to be assigned in the test harness.
  type t_sbi_config is
  record
    max_wait_cycles          : integer;
    max_wait_cycles_severity : t_alert_level;
  end record;

  constant C_SBI_CONFIG_DEFAULT : t_sbi_config := (
    max_wait_cycles          => 10,
    max_wait_cycles_severity => failure
    );

  ----------------------------------------------------
  -- BFM procedures
  ----------------------------------------------------
  procedure sbi_write (
    constant addr_value          : in unsigned;
    constant data_value          : in std_logic_vector;
    constant msg           : in string;
    signal   clk           : in std_logic;
    signal   cs            : inout std_logic;
    signal   addr          : inout unsigned;
    signal   rd            : inout std_logic;
    signal   wr            : inout std_logic;
    signal   rdy           : in  std_logic;
    signal   din           : inout std_logic_vector;
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
    signal   cs            : inout std_logic;
    signal   addr          : inout unsigned;
    signal   rd            : inout std_logic;
    signal   wr            : inout std_logic;
    signal   rdy           : in  std_logic;
    signal   dout          : in  std_logic_vector;
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
    signal   cs            : inout std_logic;
    signal   addr          : inout unsigned;
    signal   rd            : inout std_logic;
    signal   wr            : inout std_logic;
    signal   rdy           : in  std_logic;
    signal   dout          : in  std_logic_vector;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
    );
    
  procedure sbi_expect (
    constant addr_value             : in unsigned;
    constant data_exp               : in std_logic_vector;
    constant within_nth_occurrence  : in integer := 1;
    constant timeout                : in time := 0 ns;
    constant alert_level            : in t_alert_level := ERROR;
    constant msg                    : in string;
    signal   clk                    : in std_logic;
    signal   cs                     : inout std_logic;
    signal   addr                   : inout unsigned;
    signal   rd                     : inout std_logic;
    signal   wr                     : inout std_logic;
    signal   rdy                    : in  std_logic;
    signal   dout                   : in  std_logic_vector;
    constant clk_period             : in time;
    constant scope                  : in string := C_SCOPE;
    constant msg_id_panel           : in t_msg_id_panel  := shared_msg_id_panel;
    constant config                 : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
    );

end package sbi_bfm_pkg;


--=================================================================================================
--=================================================================================================

package body sbi_bfm_pkg is

  ---------------------------------------------------------------------------------
  -- write
  ---------------------------------------------------------------------------------
  procedure sbi_write (
    constant addr_value          : in unsigned;
    constant data_value          : in std_logic_vector;
    constant msg           : in string;
    signal   clk           : in std_logic;
    signal   cs            : inout std_logic;
    signal   addr          : inout unsigned;
    signal   rd            : inout std_logic;
    signal   wr            : inout std_logic;
    signal   rdy           : in  std_logic;
    signal   din           : inout std_logic_vector;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
  ) is
    constant proc_name   : string := "sbi_write";
    constant proc_call   : string := "sbi_write(A:" & to_string(addr_value, HEX, AS_IS, INCL_RADIX) &
                                    ", " & to_string(data_value, HEX, AS_IS, INCL_RADIX) & ")";
    -- Normalise to the DUT addr/data widths
    variable v_normalised_addr  : unsigned(addr'length-1 downto 0) :=
        normalize_and_check(addr_value, addr, ALLOW_WIDER_NARROWER, "addr_value", "sbi_core_in.addr", msg);
    variable v_normalised_data  : std_logic_vector(din'length-1 downto 0) :=
        normalize_and_check(data_value, din, ALLOW_NARROWER, "data_value", "sbi_core_in.din", msg);
    variable v_clk_cycles_waited : natural := 0;
  begin
    wait_until_given_time_after_rising_edge(clk, clk_period/4);
    cs   <= '1';
    wr   <= '1';
    rd   <= '0';
    addr <= v_normalised_addr;
    din  <= v_normalised_data;

    wait for clk_period;
    while (rdy = '0') loop
      wait for clk_period;
      v_clk_cycles_waited := v_clk_cycles_waited + 1;
      check_value(v_clk_cycles_waited <= config.max_wait_cycles, config.max_wait_cycles_severity,
          ": Timeout while waiting for sbi ready", scope, ID_NEVER, msg_id_panel, proc_call);
    end loop;

    cs  <= '0';
    wr  <= '0';
    log(ID_BFM, proc_call & " completed. " & msg, scope, msg_id_panel);
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
    signal   cs            : inout std_logic;
    signal   addr          : inout unsigned;
    signal   rd            : inout std_logic;
    signal   wr            : inout std_logic;
    signal   rdy           : in  std_logic;
    signal   dout          : in  std_logic_vector;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT;
    constant proc_name     : in string  := "sbi_read"  -- overwrite if called from other procedure like sbi_check
  ) is
    constant proc_call     : string := "sbi_read(A:" & to_string(addr_value, HEX, AS_IS, INCL_RADIX) & ")";
    -- Normalize to the DUT addr/data widths
    variable v_normalised_addr  : unsigned(addr'length-1 downto 0) :=
      normalize_and_check(addr_value, addr, ALLOW_WIDER_NARROWER, "addr_value", "sbi_core_in.addr", msg);
    variable v_data_value   : std_logic_vector(data_value'range);
    variable v_clk_cycles_waited : natural := 0;
  begin
    wait_until_given_time_after_rising_edge(clk, clk_period/4);
    cs   <= '1';
    wr   <= '0';
    rd   <= '1';
    addr <= v_normalised_addr;
    wait for clk_period;
    while (rdy = '0') loop
      wait for clk_period;
      v_clk_cycles_waited := v_clk_cycles_waited + 1;
      check_value(v_clk_cycles_waited <= config.max_wait_cycles, config.max_wait_cycles_severity,
          ": Timeout while waiting for sbi ready", scope, ID_NEVER, msg_id_panel, proc_call);
    end loop;

    cs  <= '0';
    rd  <= '0';
    v_data_value  := dout;
    data_value    := v_data_value;
    if proc_name = "sbi_read" then
      log(ID_BFM, proc_call & "=> " & to_string(v_data_value, HEX, SKIP_LEADING_0, INCL_RADIX) & ". " & msg, scope, msg_id_panel);
    else
      -- Log will be handled by calling procedure (e.g. sbi_check)
    end if;
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
    signal   cs            : inout std_logic;
    signal   addr          : inout unsigned;
    signal   rd            : inout std_logic;
    signal   wr            : inout std_logic;
    signal   rdy           : in  std_logic;
    signal   dout          : in  std_logic_vector;
    constant clk_period    : in time;
    constant scope         : in string := C_SCOPE;
    constant msg_id_panel  : in t_msg_id_panel  := shared_msg_id_panel;
    constant config        : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
  ) is
    constant proc_name     : string := "sbi_check";
    constant proc_call     : string := "sbi_check(A:" & to_string(addr_value, HEX, AS_IS, INCL_RADIX) &
                                      ", "  & to_string(data_exp, HEX, AS_IS, INCL_RADIX) & ")";
    -- Normalize to the DUT addr/data widths
    variable v_normalised_addr  : unsigned(addr'length-1 downto 0) :=
      normalize_and_check(addr_value, addr, ALLOW_WIDER_NARROWER, "addr_value", "sbi_core_in.addr", msg);
    -- Helper variables
    variable v_data_value : std_logic_vector(dout'length - 1 downto 0);
    variable v_check_ok : boolean;
    variable v_clk_cycles_waited : natural := 0;
  begin
    sbi_read(addr_value, v_data_value, msg, clk, cs, addr, rd, wr, rdy, dout, clk_period, scope, msg_id_panel, config, proc_name);

    -- Compare values, but ignore any leading zero's if widths are different.
    -- Use ID_NEVER so that check_value method does not log when check is OK,
    -- log it here instead.
    v_check_ok := check_value(v_data_value, data_exp, alert_level, msg, scope, HEX_BIN_IF_INVALID, SKIP_LEADING_0, ID_NEVER, msg_id_panel, proc_call);
    if v_check_ok then
      log(ID_BFM, proc_call & "=> OK, read data = " & to_string(v_data_value, HEX, SKIP_LEADING_0, INCL_RADIX) & ". " & msg, scope, msg_id_panel);
    end if;
  end procedure;

  ---------------------------------------------------------------------------------
  -- expect()
  ---------------------------------------------------------------------------------
  -- Perform a read operation, then compare the read value to the expected value.
  -- The checking is repeated until timeout or N occurrences (reads) without expected data.
  procedure sbi_expect (
    constant addr_value             : in unsigned;
    constant data_exp               : in std_logic_vector;
    constant within_nth_occurrence  : in integer        := 1;
    constant timeout                : in time           := 0 ns;
    constant alert_level            : in t_alert_level  := ERROR;
    constant msg                    : in string;
    signal   clk                    : in std_logic;
    signal   cs                     : inout std_logic;
    signal   addr                   : inout unsigned;
    signal   rd                     : inout std_logic;
    signal   wr                     : inout std_logic;
    signal   rdy                    : in  std_logic;
    signal   dout                   : in  std_logic_vector;
    constant clk_period             : in time;
    constant scope                  : in string := C_SCOPE;
    constant msg_id_panel           : in t_msg_id_panel  := shared_msg_id_panel;
    constant config                 : in t_sbi_config    := C_SBI_CONFIG_DEFAULT
  ) is
    constant proc_name     : string   := "sbi_expect";
    constant proc_call     : string   := proc_name & "(A:" & to_string(addr_value, HEX, AS_IS, INCL_RADIX) &
                                         ", "  & to_string(data_exp, HEX, AS_IS, INCL_RADIX) & ")";
    constant start_time    : time     := now;
    -- Normalise to the DUT addr/data widths
    variable v_normalised_addr        : unsigned(addr'length-1 downto 0) :=
      normalize_and_check(addr_value, addr, ALLOW_WIDER_NARROWER, "addr_value", "sbi_core_in.addr", msg);
    -- Helper variables
    variable v_data_value             : std_logic_vector(dout'length - 1 downto 0);
    variable v_check_ok               : boolean;
    variable v_timeout_ok             : boolean;
    variable v_num_of_occurrences_ok  : boolean;
    variable v_num_of_occurrences     : integer := 0;
    variable v_clk_cycles_waited      : natural := 0;
  begin
    -- Check for timeout = 0 and within_nth_occurrence = 0. This combination can result in an infinite loop if the expected data does not appear.
    if within_nth_occurrence = 0 and timeout = 0 ns then
      alert(TB_WARNING, proc_name & " called with timeout=0 and within_nth_occurrence=0. This can result in an infinite loop.");
    end if;
    
    log(ID_BFM, "Expecting data " & to_string(data_exp, HEX, SKIP_LEADING_0, INCL_RADIX) & " within " & to_string(within_nth_occurrence) & " occurrences and " & to_string(timeout,ns) & ".", scope, msg_id_panel);
    
    -- Initial status of the checks
    v_check_ok := false;
    v_timeout_ok := true;
    v_num_of_occurrences_ok := true;
    
    while not v_check_ok and v_timeout_ok and v_num_of_occurrences_ok loop
      -- Read data on SBI register
      sbi_read(v_normalised_addr, v_data_value, msg, clk, cs, addr, rd, wr, rdy, dout, clk_period, scope, msg_id_panel, config, proc_name);
      
      -- Evaluate data
      if v_data_value = data_exp then
        v_check_ok := true;
      else
        v_check_ok := false;
      end if;

      -- Evaluate number of occurrences, if limited by user
      v_num_of_occurrences := v_num_of_occurrences + 1;
      if within_nth_occurrence > 0 then
        v_num_of_occurrences_ok := v_num_of_occurrences < within_nth_occurrence;
      end if;
      
      -- Evaluate timeout, if specified by user
      if timeout = 0 ns then
        v_timeout_ok := true;
      else
        v_timeout_ok := (now - start_time) < timeout;
      end if;
      
    end loop;

    if v_check_ok then
      log(ID_BFM, proc_call & "=> OK, read data = " & to_string(v_data_value, HEX, SKIP_LEADING_0, INCL_RADIX) & " after " & to_string(v_num_of_occurrences) & " occurrences and " & to_string((now - start_time),ns) & ". " & msg, scope, msg_id_panel);
    elsif not v_timeout_ok then 
      alert(alert_level, proc_call & "=> Failed due to timeout. Did not get expected value " & to_string(data_exp, HEX, AS_IS, INCL_RADIX) & " before time " & to_string(timeout,ns) & ". " & msg, scope);
    else
      alert(alert_level, proc_call & "=> Failed. Expected value " & to_string(data_exp, HEX, AS_IS, INCL_RADIX) & " did not appear within " & to_string(within_nth_occurrence) & " occurrences. " & msg, scope);
    end if;
  end procedure;

end package body sbi_bfm_pkg;



