onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/clk
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rstB
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/clkEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/pc
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/inst_in
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/dec/rInstrustion
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
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wPcCondEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wPcNextCond
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wPcReturn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wJmp_occur
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wHazardRs1
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wHazardRs2
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rReg_d
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wAluA
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wAluB
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wFunct3_aluIn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wFunct7_aluIn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wAluSextEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rWrData
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRegWrEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rRegWrEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRegWrData
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRs1Data
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRs2Data
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/rOp_memLd
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRamByteEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRamHalfEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRamWordEn
add wave -noupdate -expand -group Core -radix hexadecimal /top_tb/dut/core/wRamUnsignedEn
add wave -noupdate -radix hexadecimal -childformat {{{/top_tb/dut/core/reg_module/gprf[0]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[1]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[2]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[3]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[4]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[5]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[6]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[7]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[8]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[9]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[10]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[11]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[12]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[13]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[14]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[15]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[16]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[17]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[18]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[19]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[20]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[21]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[22]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[23]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[24]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[25]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[26]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[27]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[28]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[29]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[30]} -radix hexadecimal} {{/top_tb/dut/core/reg_module/gprf[31]} -radix hexadecimal}} -expand -subitemconfig {{/top_tb/dut/core/reg_module/gprf[0]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[1]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[2]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[3]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[4]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[5]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[6]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[7]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[8]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[9]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[10]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[11]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[12]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[13]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[14]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[15]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[16]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[17]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[18]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[19]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[20]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[21]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[22]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[23]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[24]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[25]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[26]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[27]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[28]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[29]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[30]} {-height 15 -radix hexadecimal} {/top_tb/dut/core/reg_module/gprf[31]} {-height 15 -radix hexadecimal}} /top_tb/dut/core/reg_module/gprf
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/wrData
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/wrEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/rdEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/dataOut
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/outEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/byteEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/halfEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/wordEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/unsignedEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/wRamByte_we
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/RamDataOut
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/rByteEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/rHalfEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/rUnsignedEn
add wave -noupdate -expand -group RAM -radix hexadecimal /top_tb/dut/ram/BRAM/ram
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rx
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/tx
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/clk
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rstB
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/addr
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wrData
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wrEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rdEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/dataOut
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/outEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wRxFfDataEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wRxFfDataOut
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wTxFfRdEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFFTxData
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wTxFfEmpty
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wRxFfEmpty
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wRxFfFull
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wTxFfFull
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFfrxDataOut
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFfrxRdEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFftxDataIn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wFftxWrEn
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/wUartDataout
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rUCR
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/rAddr
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/ffrx/buffer
add wave -noupdate -expand -group UART -radix hexadecimal /top_tb/dut/uart_module/fftx/buffer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35400 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 233
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
WaveRestoreZoom {27600 ps} {40400 ps}
