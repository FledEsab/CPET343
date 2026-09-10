vlib work
vcom -93 -work work ../../src/generic_adder_arch_sub.vhd
vcom -93 -work work ../../src/generic_adder_arch.vhd
vcom -93 -work work {C:/Users/Ethan/Documents/CPET 343/Labs/Labs/lab2/full_adder_single_bit_arch/sim/src/generic_adder_tb.vhd}
vsim -novopt generic_adder_tb
do wave.do
run 100 ns
