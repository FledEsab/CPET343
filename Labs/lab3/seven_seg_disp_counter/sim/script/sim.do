vlib work
vcom -93 -work work ../../src/seven_seg_sim.vhd
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../../src/hex_ones_dig.vhd
vcom -93 -work work ../../src/generic_adder_beh.vhd
vcom -93 -work work ../src/seven_seg_tb.vhd

vsim -voptargs=+acc work.seven_seg_tb
do wave.do
run 1500 ns
