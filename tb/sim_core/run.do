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
vlog -cover bcse -work work ../../rtl/RV32I_core/ram_wController.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/branch_unit.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/rv32i_core.sv

#--------------------------------#
#--     Compile Package        --#
#--------------------------------#
vlog -cover bcse -work work ../Program_Mem.sv

#--------------------------------#
#--   	Compile Test Bench     --#
#--------------------------------#
vlog -work work ../core_tb.sv

vsim -t 100ps -novopt work.core_tb

view wave

do wave.do

view structure
view signals

run -all