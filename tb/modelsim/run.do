##
quit -sim
vlib work

#--------------------------------#
#--      Compile Source        --#
#--------------------------------#
vlog -cover bcse -work work ../../rtl/RV32I_core/inst_dec.sv
vlog -cover bcse -work work ../../rtl/RV32I_core/pc_reg.sv

#--------------------------------#
#--     Compile Package        --#
#--------------------------------#


#--------------------------------#
#--   	Compile Test Bench     --#
#--------------------------------#
vlog -work work ../pc_inst_dec_tb.sv

vsim -t 100ps -novopt work.pc_inst_dec_tb

view wave

do wave.do

view structure
view signals

run -all