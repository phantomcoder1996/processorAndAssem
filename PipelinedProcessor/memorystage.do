vsim -gui work.memorystage

add wave -r /*
force -freeze sim:/memorystage/clk 1 0, 0 {50 ps} -r 100

force -freeze sim:/memorystage/rst 1 0
run
force -freeze sim:/memorystage/rst 0 0
run
force -freeze sim:/memorystage/ExecuteMemory 00000000010000000000000001000000000000000110000000000000101000010 0
force -freeze sim:/memorystage/MemWBRDst 0000000000001010 0

force -freeze sim:/memorystage/inctrlSignals 00111000 0
force -freeze sim:/memorystage/x 000000000011000 0

run

force -freeze sim:/memorystage/ExecuteMemory 00000000010000000000000001000000000000000110000000000000101000010 0
force -freeze sim:/memorystage/MemWBRDst 0000000000001010 0

force -freeze sim:/memorystage/inctrlSignals 01111000 0
force -freeze sim:/memorystage/x 000000000000000 0

run
force -freeze sim:/memorystage/ExecuteMemory 00000000010000000000000001000000000000000110000000000000101000010 0
force -freeze sim:/memorystage/MemWBRDst 0000000000001010 0

force -freeze sim:/memorystage/inctrlSignals 10111000 0
force -freeze sim:/memorystage/x 000000000000000 0
run