##
quit -sim
vlib work

#--------------------------------#
#--      Compile Source        --#
#--------------------------------#
vlog -cover bcse -work work ../../rtl/RV32I_core/alu.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/inst_dec.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/pc_reg.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/reg_file.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/reg_file_sky130sram.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/ram_wController.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/branch_unit.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/rv32i_core.sv

vlog -cover bcse -work work ../../rtl/uart/uart_tx.sv
vlog -cover bcse -work work ../../rtl/uart/uart_rx.sv
vlog -cover bcse -work work ../../rtl/uart/fifo8bits.sv
vlog -cover bcse -work work ../../rtl/uart/uart.sv

vlog -cover bcse -work work ../../rtl/Programmer/prog.sv

vlog -cover bcse -work work ../../rtl/IO_Port/io_buf.sv
vlog -cover bcse -work work ../../rtl/IO_Port/port.sv

vlog -cover bcse -work work ../../rtl/addition_module/single_tx.sv
vlog -cover bcse -work work ../../rtl/addition_module/sky130_sram_1w1r_8x.sv

vlog -cover bcse -work work ../../rtl/Top_Module/RV32I_top_SoC.sv


#--------------------------------#
#--     Compile Package        --#
#--------------------------------#
vlog -cover bcse -work work ../../rtl/Programmer/prog_ram_w8r32.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/bram_sp_byte.sv

#--------------------------------#
#--   	Compile Test Bench     --#
#--------------------------------#
vlog -work work ../top_tb.sv

vsim -t 100ps -novopt work.top_tb

view wave

do wave.do

view structure
view signals

run -all