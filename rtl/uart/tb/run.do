##
quit -sim
vlib work

#--------------------------------#
#--      Compile Source        --#
#--------------------------------#
vlog -cover bcse -work work ../uart_tx.sv
vlog -cover bcse -work work ../uart_rx.sv
vlog -cover bcse -work work ../fifo8bits.sv

#--------------------------------#
#--     Compile Package        --#
#--------------------------------#

#--------------------------------#
#--   	Compile Test Bench     --#
#--------------------------------#
vlog -cover bcse -work work uart_tb.sv

vsim -t 100ps -novopt work.uart_tb

view wave

do wave.do

view structure
view signals

run -all