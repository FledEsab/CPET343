@echo off
set MODELSIM_BIN=C:\intelFPGA\18.1\modelsim_ase\win32aloem
"%MODELSIM_BIN%\vsim.exe" -do "do sim.do"
pause