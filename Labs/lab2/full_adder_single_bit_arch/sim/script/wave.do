onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /generic_adder_tb/uut/a
add wave -noupdate /generic_adder_tb/uut/b
add wave -noupdate /generic_adder_tb/uut/cin
add wave -noupdate /generic_adder_tb/uut/sum
add wave -noupdate /generic_adder_tb/uut/cout
add wave -noupdate /generic_adder_tb/a
add wave -noupdate /generic_adder_tb/b
add wave -noupdate /generic_adder_tb/cin
add wave -noupdate /generic_adder_tb/sum
add wave -noupdate /generic_adder_tb/cout
add wave -noupdate /generic_adder_tb/cin_guard
add wave -noupdate /generic_adder_tb/NUM_BITS
add wave -noupdate /generic_adder_tb/SEQUENTIAL_FLAG
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11320 ps} 0}
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
