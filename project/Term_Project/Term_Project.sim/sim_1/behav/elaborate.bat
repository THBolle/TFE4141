@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto fde4a3f3ae914b7f9aeed5827be26b3e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot TopLevelStateMachine_behav xil_defaultlib.TopLevelStateMachine -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
