vlib work
vcom -93 -work work ../../src/generic_adder
vcom -93 -work work ../../src/generic_subtractor.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../../src/edge_detector.vhd
vcom -93 -work work ../../src/bcd_to_sev_seg.vhd
vcom -93 -work work ../../src/synchronizer_8bit.vhd
vcom -93 -work work ../../src/core_add_sub.vhd
vcom -93 -work work ../../src/add_sub_8bit_tb.vhd
vsim -voptargs=+acc seven_seg_tb
do wave.do
run 500 ns
