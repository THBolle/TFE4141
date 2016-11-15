#========================================================================================================================
# Copyright (c) 2015 by Bitvis AS.  All rights reserved.
#
# BITVIS UTILITY LIBRARY AND ANY PART THEREOF ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH BITVIS UTILITY LIBRARY.
#========================================================================================================================

# - Compile dependencies (ieee_proposed)
# - Compile src (irqc)
# - Compile testbench dependencies (Bitvis Utility Library, vhdl 93 version)
# - Compile and simulate irqc testbench

if {[batch_mode]} {
  onerror {abort all; exit -f -code 1}
  onbreak {abort all; exit -f}
} else {
  onerror {abort all}
}

quit -sim

quietly set vhdl_version "93"

quietly set tb_part_path ../../bitvis_irqc
do $tb_part_path/script/compile_dep.do $tb_part_path $vhdl_version
do $tb_part_path/script/compile_src.do $tb_part_path $vhdl_version
do $tb_part_path/script/compile_tb_dep.do $tb_part_path $vhdl_version
do $tb_part_path/script/compile_tb.do  $tb_part_path $vhdl_version
do $tb_part_path/script/simulate_tb.do $tb_part_path $vhdl_version


