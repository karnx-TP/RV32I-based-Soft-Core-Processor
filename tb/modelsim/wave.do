onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pc_inst_dec_tb/CLK_PERIOD
add wave -noupdate /pc_inst_dec_tb/clk
add wave -noupdate /pc_inst_dec_tb/rstB
add wave -noupdate /pc_inst_dec_tb/pc
add wave -noupdate /pc_inst_dec_tb/instruction_in
add wave -noupdate /pc_inst_dec_tb/Op_code
add wave -noupdate /pc_inst_dec_tb/r_type
add wave -noupdate /pc_inst_dec_tb/i_type
add wave -noupdate /pc_inst_dec_tb/s_type
add wave -noupdate /pc_inst_dec_tb/b_type
add wave -noupdate /pc_inst_dec_tb/j_type
add wave -noupdate /pc_inst_dec_tb/u_type
add wave -noupdate /pc_inst_dec_tb/funct3
add wave -noupdate /pc_inst_dec_tb/funct7
add wave -noupdate /pc_inst_dec_tb/reg_d
add wave -noupdate /pc_inst_dec_tb/reg_s1
add wave -noupdate /pc_inst_dec_tb/reg_s2
add wave -noupdate /pc_inst_dec_tb/imm13_b
add wave -noupdate /pc_inst_dec_tb/imm12_i_s
add wave -noupdate /pc_inst_dec_tb/imm32_u
add wave -noupdate /pc_inst_dec_tb/imm21_j
add wave -noupdate /pc_inst_dec_tb/op_lui
add wave -noupdate /pc_inst_dec_tb/op_auipc
add wave -noupdate /pc_inst_dec_tb/op_jal
add wave -noupdate /pc_inst_dec_tb/op_jalr
add wave -noupdate /pc_inst_dec_tb/op_branch
add wave -noupdate /pc_inst_dec_tb/op_memLd
add wave -noupdate /pc_inst_dec_tb/op_intRegImm
add wave -noupdate /pc_inst_dec_tb/op_memSt
add wave -noupdate /pc_inst_dec_tb/op_consShf
add wave -noupdate /pc_inst_dec_tb/op_intRegReg
add wave -noupdate /pc_inst_dec_tb/op_efence
add wave -noupdate /pc_inst_dec_tb/op_ecb
add wave -noupdate /pc_inst_dec_tb/Exp_op
add wave -noupdate /pc_inst_dec_tb/Exp_rd
add wave -noupdate /pc_inst_dec_tb/Exp_rs1
add wave -noupdate /pc_inst_dec_tb/Exp_rs2
add wave -noupdate /pc_inst_dec_tb/Exp_funct3
add wave -noupdate /pc_inst_dec_tb/Exp_funct7
add wave -noupdate -expand -group PC /pc_inst_dec_tb/rpc/clk
add wave -noupdate -expand -group PC /pc_inst_dec_tb/rpc/rstB
add wave -noupdate -expand -group PC /pc_inst_dec_tb/rpc/clkEn
add wave -noupdate -expand -group PC /pc_inst_dec_tb/rpc/pc_out
add wave -noupdate -expand -group PC /pc_inst_dec_tb/rpc/rPC_current
add wave -noupdate -expand -group PC /pc_inst_dec_tb/rpc/wPC_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {58700 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 206
configure wave -valuecolwidth 131
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
WaveRestoreZoom {17800 ps} {136 ns}
