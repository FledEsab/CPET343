vlib work
vcom -93 -work work ../../src/calculator_top.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/bcd_to_sev_seg.vhd
vcom -93 -work work ../../src/generic_calculator.vhd
vcom -93 -work work ../../src/synchronizer_3bit.vhd
vcom -93 -work work ../src/add_sub_tb.vhd
vsim work.add_sub_tb
do wave.do
run 3 us
