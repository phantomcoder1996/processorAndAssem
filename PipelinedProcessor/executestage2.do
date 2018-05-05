vsim -gui work.executestage
add wave -r /*

force -freeze sim:/executestage/DecodeExecute 01000000000100000000000000010011111111111111100010100010 0
force -freeze sim:/executestage/inCtrlSignals 00011010001 0
force -freeze sim:/executestage/WriteBack 000000000000010100000000000000110000010 0
force -freeze sim:/executestage/x 000000000000000 0
force -freeze sim:/executestage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/executestage/rst 1 0
force -freeze sim:/executestage/stall 0 0

run
force -freeze sim:/executestage/rst 0 0
run
force -freeze sim:/executestage/DecodeExecute 01000000000100000000000000001011111111111111100010100010 0
run