onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_tb/TM
add wave -noupdate /uart_tb/rx_module/clk
add wave -noupdate /uart_tb/rx_module/rstB
add wave -noupdate -expand -group RX -radix binary /uart_tb/data
add wave -noupdate -expand -group RX -radix binary /uart_tb/data_ss
add wave -noupdate -expand -group RX /uart_tb/rx_module/rx
add wave -noupdate -expand -group RX /uart_tb/rx_module/dataEn
add wave -noupdate -expand -group RX -radix hexadecimal /uart_tb/rx_module/dataOut
add wave -noupdate -expand -group RX /uart_tb/rx_module/wState_next
add wave -noupdate -expand -group RX /uart_tb/rx_module/rState_current
add wave -noupdate -expand -group RX /uart_tb/rx_module/rParData
add wave -noupdate -expand -group RX /uart_tb/rx_module/rBaudCnt
add wave -noupdate -expand -group RX /uart_tb/rx_module/rBitInCnt
add wave -noupdate -expand -group RX /uart_tb/rx_module/rRx_1
add wave -noupdate -expand -group RX /uart_tb/rx_module/rRx
add wave -noupdate -expand -group RX /uart_tb/rx_module/wMidBaud
add wave -noupdate -expand -group FF -radix hexadecimal /uart_tb/ff/buffer
add wave -noupdate -expand -group FF /uart_tb/ff/data_in
add wave -noupdate -expand -group FF /uart_tb/ff/FfWrEn
add wave -noupdate -expand -group FF /uart_tb/ff/FfRdEn
add wave -noupdate -expand -group FF /uart_tb/ff/data_out
add wave -noupdate -expand -group FF /uart_tb/ff/FfEmpty
add wave -noupdate -expand -group FF /uart_tb/ff/FfFull
add wave -noupdate /uart_tb/tx_module/clk
add wave -noupdate /uart_tb/tx_module/rstB
add wave -noupdate /uart_tb/tx_module/ffEmpty
add wave -noupdate /uart_tb/tx_module/rdEn
add wave -noupdate /uart_tb/tx_module/rdData
add wave -noupdate /uart_tb/tx_module/tx
add wave -noupdate /uart_tb/tx_module/wState_next
add wave -noupdate /uart_tb/tx_module/rState_current
add wave -noupdate /uart_tb/tx_module/rParData
add wave -noupdate /uart_tb/tx_module/rBaudCnt
add wave -noupdate /uart_tb/tx_module/rBitInCnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8264700 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 210
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
WaveRestoreZoom {8255 ns} {8270200 ps}
