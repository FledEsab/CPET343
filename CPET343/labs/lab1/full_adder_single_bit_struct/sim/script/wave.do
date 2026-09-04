onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /full_adder_single_bit_struct_tb/a
add wave -noupdate /full_adder_single_bit_struct_tb/b
add wave -noupdate /full_adder_single_bit_struct_tb/cin
add wave -noupdate /full_adder_single_bit_struct_tb/sum
add wave -noupdate /full_adder_single_bit_struct_tb/cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 112
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {105 ns}
