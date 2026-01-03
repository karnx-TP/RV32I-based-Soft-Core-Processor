##
quit -sim
vlib work

#--------------------------------#
#--      Compile Source        --#
#--------------------------------#
vlog -cover bcse -work work ../../rtl/RV32I_core/alu.sv

#--------------------------------#
#--     Compile Package        --#
#--------------------------------#


#--------------------------------#
#--   	Compile Test Bench     --#
#--------------------------------#
vlog -work work ../alu_tb.sv

vsim -t 100ps -novopt work.alu_tb

view wave

do wave.do

view structure
view signals

run -all