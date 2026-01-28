onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/clk
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rstB
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wJmp_occur
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rJumping1
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wJumping
add wave -noupdate -expand -group Core /top_tb/dut/progEn
add wave -noupdate -expand -group Core -group DEC /top_tb/dut/core/dec/clk
add wave -noupdate -expand -group Core -group DEC /top_tb/dut/core/dec/rstB
add wave -noupdate -expand -group Core -group DEC /top_tb/dut/core/dec/clkEn
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/instruction_in
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/jmp
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/stall
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/Op_code
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/r_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/i_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/s_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/b_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/j_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/u_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/funct3
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/funct7
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/reg_d
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/reg_s1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/reg_s2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wReg_s1_out
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wReg_s2_out
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/imm13_b
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/imm12_i_s
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/imm32_u
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/imm21_j
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_lui
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_auipc
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_jal
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_jalr
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_branch
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_memLd
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_intRegImm
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_memSt
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_consShf
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_intRegReg
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_efence
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/op_ecb
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/hazardS1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/hazardS2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/hazardS1_2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/hazardS2_2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/hazardS1_3
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/hazardS2_3
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wInst_in
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rInstrustion1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rInstrustion2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rJmp
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wOp_code
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_lui
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_auipc
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_jal
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_jalr
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_branch
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_memLd
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_intRegImm
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_memSt
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_consShf
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_intRegReg
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_efence
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wop_ecb
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wNOP
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wr_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wi_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/ws_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wb_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wj_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wu_type
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wfunct3
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wfunct7
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wreg_d
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wreg_s1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wreg_s2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wimm13_b
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wimm12_i_s
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wimm32_u
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wimm21_j
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rRegWrEn
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rRegWrEn2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rRegWrEn3
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rOp_memLd
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wHazardRs1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wHazardRs2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wHazard_2_Rs1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wHazard_2_Rs2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wHazard_3_Rs1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wHazard_3_Rs2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wHazardStall_EXE
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rReg_d2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rReg_d3
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wStall
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wStall_1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rStall
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rStall2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rPostStall
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rStallCnt1
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/rStallCnt2
add wave -noupdate -expand -group Core -group DEC -radix hexadecimal /top_tb/dut/core/dec/wHazardStall_MEM
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/pc
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/inst_in
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/dec/wInst_in
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/dec/jmp
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/addr
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/dataBusOut
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wrEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rdEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/RamMode
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/dataBusIn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/dataBusInEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/Op_code
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/r_type
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/i_type
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/s_type
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/b_type
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/j_type
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/u_type
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/funct3
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/funct7
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/reg_d
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/reg_s1
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/reg_s2
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/imm13_b
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/imm12_i_s
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/imm32_u
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/imm21_j
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_lui
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_auipc
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_jal
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_jalr
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_branch
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_memLd
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_intRegImm
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_memSt
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_consShf
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_intRegReg
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_efence
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/op_ecb
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wAluOut
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wAluFlag
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wPc_int
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wPcNextCond
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wPcReturn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wJmp_occur
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wHazardRs1
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wHazardRs2
add wave -noupdate -expand -group Core /top_tb/dut/core/wHazard_2_Rs1
add wave -noupdate -expand -group Core /top_tb/dut/core/wHazard_2_Rs2
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rReg_d
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wAluA
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wAluB
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wFunct3_aluIn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wFunct7_aluIn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wAluSextEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rReg_d2
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rWrData
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rWrDataWB
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRegWrData
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rRegWrEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rRegWrEn2
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRegWrEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wReg_s1_out
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRs1Data
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRs2Data
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rOp_memLd
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRamByteEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRamHalfEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRamWordEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRamUnsignedEn
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/clk0
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/csb0
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/web0
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/wmask0
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/addr0
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/din0
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/dout0
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/clk1
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/csb1
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/addr1
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/dout1
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/csb0_reg
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/web0_reg
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/wmask0_reg
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/addr0_reg
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/din0_reg
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/csb1_reg
add wave -noupdate -expand -group REG -radix hexadecimal /top_tb/dut/core/reg_module/sram_reg1/addr1_reg
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[0]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[1]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[2]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[3]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[4]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[5]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[6]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[7]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[8]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[9]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[10]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[11]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[12]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[13]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[14]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[15]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[16]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[17]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[18]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[19]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[20]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[21]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[22]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[23]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[24]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[25]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[26]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[27]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[28]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[29]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[30]}
add wave -noupdate -expand -group REG -expand -group GPRF -height 15 -radix hexadecimal {/top_tb/dut/core/reg_module/sram_reg1/mem[31]}
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/wrData
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/addr
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/wrEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/rdEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/dataOut
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/outEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/byteEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/halfEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/wordEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/unsignedEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/wRamByte_we
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/RamDataOut
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/rByteEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/rHalfEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/rUnsignedEn
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/wDataIn
add wave -noupdate -group RAM -radix binary /top_tb/dut/ram/wRamByte_we
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/wByteSel
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/wHalfSel
add wave -noupdate -group RAM -radix hexadecimal /top_tb/dut/ram/BRAM/ram
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rx
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/tx
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/clk
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rstB
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/addr
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wrData
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wrEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wRxFfEmpty
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rdEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/dataOut
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/outEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wRxFfDataEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wRxFfDataOut
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wTxFfRdEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFFTxData
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wTxFfEmpty
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wRxFfFull
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wTxFfFull
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFfrxDataOut
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFfrxRdEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFftxDataIn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFftxWrEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wUartDataout
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rUCR
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rAddr
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/fftx/buffer
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/ffrx/buffer
add wave -noupdate -group Prog /top_tb/dut/programmer_module/clk
add wave -noupdate -group Prog /top_tb/dut/programmer_module/rstB
add wave -noupdate -group Prog /top_tb/dut/programmer_module/progEn
add wave -noupdate -group Prog /top_tb/dut/programmer_module/memWrEn
add wave -noupdate -group Prog -radix hexadecimal /top_tb/dut/programmer_module/memAddr
add wave -noupdate -group Prog -radix hexadecimal /top_tb/dut/programmer_module/memData
add wave -noupdate -group Prog -radix hexadecimal /top_tb/dut/programmer_module/rxFfEmpty
add wave -noupdate -group Prog -radix hexadecimal /top_tb/dut/programmer_module/rxRdEn
add wave -noupdate -group Prog -radix hexadecimal /top_tb/dut/programmer_module/rxData
add wave -noupdate -group Prog -radix hexadecimal /top_tb/dut/programmer_module/wMemFull
add wave -noupdate -group Prog -radix hexadecimal /top_tb/dut/programmer_module/rRxRdEn
add wave -noupdate -group Prog -radix hexadecimal /top_tb/dut/programmer_module/rMemAddr
add wave -noupdate -group Prog -radix hexadecimal {/top_tb/dut/prog_ram/ram[0]}
add wave -noupdate -group Prog -radix hexadecimal {/top_tb/dut/prog_ram/ram[1]}
add wave -noupdate -group Prog -radix hexadecimal {/top_tb/dut/prog_ram/ram[2]}
add wave -noupdate -group Prog -radix hexadecimal {/top_tb/dut/prog_ram/ram[3]}
add wave -noupdate -group Prog -radix hexadecimal {/top_tb/dut/prog_ram/ram[4]}
add wave -noupdate -group Prog -radix hexadecimal {/top_tb/dut/prog_ram/ram[5]}
add wave -noupdate -group Prog -radix hexadecimal {/top_tb/dut/prog_ram/ram[6]}
add wave -noupdate -group Prog -radix hexadecimal {/top_tb/dut/prog_ram/ram[7]}
add wave -noupdate -radix hexadecimal /top_tb/rammem
add wave -noupdate -radix hexadecimal /top_tb/data
add wave -noupdate -radix hexadecimal /top_tb/data_ss
add wave -noupdate -group PORT -radix hexadecimal /top_tb/dut/io_port_module/addr
add wave -noupdate -group PORT -radix hexadecimal /top_tb/dut/io_port_module/wrData
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/wrEn
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/rdEn
add wave -noupdate -group PORT -radix hexadecimal /top_tb/dut/io_port_module/dataOut
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/outEn
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/ddr
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/pvl
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/rDDR
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/rPVL
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/rDataOut
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/pin
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/rPin_sync1
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/rPin_sync2
add wave -noupdate -group PORT -radix binary /top_tb/dut/io_port_module/rPIN
add wave -noupdate -group PORT -expand /top_tb/dut/pin
add wave -noupdate -radix hexadecimal /top_tb/dut/wDataBus
add wave -noupdate -radix hexadecimal /top_tb/dut/wDataBusEn
add wave -noupdate -group PC /top_tb/dut/core/rpc/clk
add wave -noupdate -group PC /top_tb/dut/core/rpc/rstB
add wave -noupdate -group PC /top_tb/dut/core/rpc/clkEn
add wave -noupdate -group PC /top_tb/dut/core/rpc/condEn
add wave -noupdate -group PC /top_tb/dut/core/rpc/next_pc_cond
add wave -noupdate -group PC /top_tb/dut/core/rpc/pc_out
add wave -noupdate -group PC /top_tb/dut/core/rpc/rPC_current
add wave -noupdate -group PC /top_tb/dut/core/rpc/wPC_next
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[70]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[71]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[72]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[73]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[74]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[75]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[76]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[77]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[78]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[79]}
add wave -noupdate -group RAM4test -radix hexadecimal {/top_tb/dut/prog_ram/ram[80]}
add wave -noupdate -group RAM4test /top_tb/dut/core/wReg_s1_out
add wave -noupdate -group RAM4test /top_tb/dut/core/wReg_s2_out
add wave -noupdate -group RAM4test /top_tb/dut/core/dec/wNOP
add wave -noupdate -group HAZARD /top_tb/dut/core/wHazardRs1
add wave -noupdate -group HAZARD /top_tb/dut/core/wHazardRs2
add wave -noupdate -group HAZARD /top_tb/dut/core/wHazard_2_Rs1
add wave -noupdate -group HAZARD /top_tb/dut/core/wHazard_2_Rs2
add wave -noupdate -group HAZARD -radix hexadecimal /top_tb/dut/core/rReg_d
add wave -noupdate -group HAZARD -radix hexadecimal /top_tb/dut/core/rReg_d2
add wave -noupdate -group HAZARD /top_tb/dut/core/wStall
add wave -noupdate /top_tb/dut/core/reg_module/clk
add wave -noupdate /top_tb/dut/core/reg_module/rstB
add wave -noupdate /top_tb/dut/core/reg_module/wrEn
add wave -noupdate /top_tb/dut/core/reg_module/wrData
add wave -noupdate /top_tb/dut/core/reg_module/wrAddr
add wave -noupdate /top_tb/dut/core/reg_module/rdR1Addr
add wave -noupdate /top_tb/dut/core/reg_module/rdR2Addr
add wave -noupdate -radix hexadecimal /top_tb/dut/core/reg_module/r1out
add wave -noupdate -radix hexadecimal /top_tb/dut/core/reg_module/r2out
add wave -noupdate /top_tb/dut/core/reg_module/rRdR1Addr
add wave -noupdate /top_tb/dut/core/reg_module/rRdR2Addr
add wave -noupdate /top_tb/dut/core/reg_module/wR1out
add wave -noupdate /top_tb/dut/core/reg_module/wR2out
add wave -noupdate -radix hexadecimal /top_tb/dut/core/rRs1DataBP
add wave -noupdate -radix hexadecimal /top_tb/dut/core/rRs2DataBP
add wave -noupdate -radix hexadecimal /top_tb/dut/core/wExeData
add wave -noupdate /top_tb/dut/core/rHazardRs1
add wave -noupdate /top_tb/dut/core/rHazardRs2
add wave -noupdate /top_tb/dut/core/rHazard_2_Rs1
add wave -noupdate /top_tb/dut/core/rHazard_2_Rs2
add wave -noupdate /top_tb/dut/core/rHazard_3_Rs1
add wave -noupdate /top_tb/dut/core/rHazard_3_Rs2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44094765000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 371
configure wave -valuecolwidth 100
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
WaveRestoreZoom {44094723300 ps} {44095047300 ps}
