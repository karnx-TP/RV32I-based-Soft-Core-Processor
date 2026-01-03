onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_tb/dut/r_type
add wave -noupdate /alu_tb/dut/i_type
add wave -noupdate /alu_tb/dut/funct3
add wave -noupdate /alu_tb/dut/funct7
add wave -noupdate /alu_tb/dut/imm12_i_s
add wave -noupdate /alu_tb/dut/op_jalr
add wave -noupdate /alu_tb/dut/op_intRegImm
add wave -noupdate /alu_tb/dut/op_consShf
add wave -noupdate /alu_tb/dut/op_intRegReg
add wave -noupdate /alu_tb/dut/A
add wave -noupdate /alu_tb/dut/B
add wave -noupdate /alu_tb/dut/out
add wave -noupdate /alu_tb/dut/flag
add wave -noupdate /alu_tb/dut/wOut_int
add wave -noupdate /alu_tb/dut/wfunct
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 81
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {26400 ps}
