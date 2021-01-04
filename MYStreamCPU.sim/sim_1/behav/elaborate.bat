@echo off
set xv_path=D:\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 9be5c7ac2f574e16863700781e18d199 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot main_behav xil_defaultlib.main xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
