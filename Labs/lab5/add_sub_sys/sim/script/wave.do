onerror {resume}
radix define States {
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /add_sub_8bit_tb/sim_done
add wave -noupdate -radix unsigned /add_sub_8bit_tb/a_tb
add wave -noupdate -radix unsigned /add_sub_8bit_tb/b_tb
add wave -noupdate -radix unsigned /add_sub_8bit_tb/hexOut_tb
add wave -noupdate -radix unsigned /add_sub_8bit_tb/hexA_tb
add wave -noupdate -radix unsigned /add_sub_8bit_tb/hexB_tb
add wave -noupdate /add_sub_8bit_tb/clk_tb
add wave -noupdate /add_sub_8bit_tb/reset_n_tb
add wave -noupdate /add_sub_8bit_tb/pb_tb
add wave -noupdate /add_sub_8bit_tb/led_tb
add wave -noupdate -radix unsigned /add_sub_8bit_tb/seven_seg_values
add wave -noupdate /add_sub_8bit_tb/PERIOD_c
add wave -noupdate /add_sub_8bit_tb/MAX_COUNT_c
add wave -noupdate /add_sub_8bit_tb/ZERO_c
add wave -noupdate -radix unsigned /add_sub_8bit_tb/ONE_c
add wave -noupdate -radix unsigned /add_sub_8bit_tb/TWO_c
add wave -noupdate /add_sub_8bit_tb/THREE_c
add wave -noupdate /add_sub_8bit_tb/FOUR_c
add wave -noupdate /add_sub_8bit_tb/FIVE_c
add wave -noupdate /add_sub_8bit_tb/SIX_c
add wave -noupdate /add_sub_8bit_tb/SEVEN_c
add wave -noupdate /add_sub_8bit_tb/EIGHT_c
add wave -noupdate -radix unsigned /add_sub_8bit_tb/NINE_c
add wave -noupdate -radix unsigned /add_sub_8bit_tb/A_c
add wave -noupdate /add_sub_8bit_tb/B_c
add wave -noupdate /add_sub_8bit_tb/C_c
add wave -noupdate /add_sub_8bit_tb/D_c
add wave -noupdate /add_sub_8bit_tb/E_c
add wave -noupdate -radix unsigned /add_sub_8bit_tb/F_c
add wave -noupdate /add_sub_8bit_tb/BLANK_c
add wave -noupdate /add_sub_8bit_tb/UUT/clock_50mhz
add wave -noupdate /add_sub_8bit_tb/UUT/bcd_input
add wave -noupdate /add_sub_8bit_tb/UUT/rst_n
add wave -noupdate /add_sub_8bit_tb/UUT/manual_event_clk_push_button
add wave -noupdate /add_sub_8bit_tb/UUT/hex0_ones
add wave -noupdate /add_sub_8bit_tb/UUT/hex1_tens
add wave -noupdate /add_sub_8bit_tb/UUT/hex2_hundreds
add wave -noupdate /add_sub_8bit_tb/UUT/state_debug_led
add wave -noupdate /add_sub_8bit_tb/UUT/current_state
add wave -noupdate /add_sub_8bit_tb/UUT/next_state
add wave -noupdate /add_sub_8bit_tb/UUT/a_sync
add wave -noupdate /add_sub_8bit_tb/UUT/b_sync
add wave -noupdate /add_sub_8bit_tb/UUT/a_d
add wave -noupdate /add_sub_8bit_tb/UUT/b_d
add wave -noupdate /add_sub_8bit_tb/UUT/add_o
add wave -noupdate /add_sub_8bit_tb/UUT/sub_o
add wave -noupdate /add_sub_8bit_tb/UUT/add_d
add wave -noupdate /add_sub_8bit_tb/UUT/sub_d
add wave -noupdate /add_sub_8bit_tb/UUT/sig_o
add wave -noupdate /add_sub_8bit_tb/UUT/r_o_12bits
add wave -noupdate /add_sub_8bit_tb/UUT/hex_ones
add wave -noupdate /add_sub_8bit_tb/UUT/hex_tens
add wave -noupdate /add_sub_8bit_tb/UUT/hex_hundreds
add wave -noupdate /add_sub_8bit_tb/UUT/manual_event_clk_push_button_sync
add wave -noupdate /add_sub_8bit_tb/UUT/rst_edge
add wave -noupdate /add_sub_8bit_tb/UUT/brc_a
add wave -noupdate /add_sub_8bit_tb/UUT/brc_s
add wave -noupdate /add_sub_8bit_tb/UUT/led_o_0
add wave -noupdate /add_sub_8bit_tb/UUT/led_o_1
add wave -noupdate /add_sub_8bit_tb/UUT/led_o_2
add wave -noupdate /add_sub_8bit_tb/UUT/led_o_3
add wave -noupdate /add_sub_8bit_tb/UUT/cZero0
add wave -noupdate /add_sub_8bit_tb/UUT/cZero1
add wave -noupdate /add_sub_8bit_tb/UUT/pad4Bits
add wave -noupdate /add_sub_8bit_tb/UUT/pad3Bits
add wave -noupdate /add_sub_8bit_tb/UUT/pb_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {73964 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {155204 ps}
