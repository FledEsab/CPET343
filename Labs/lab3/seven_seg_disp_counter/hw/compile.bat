
@echo off
"C:/intelFPGA_lite/18.1/quartus/bin64/quartus_sh.exe" -t compile.tcl

quartus_pgm --mode=JTAG -o P;output_files\blink.sof

pause

