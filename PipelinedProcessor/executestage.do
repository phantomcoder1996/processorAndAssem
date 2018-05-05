vsim -gui work.executestage
add wave  \
sim:/executestage/clk \
sim:/executestage/rst \
sim:/executestage/stall \
sim:/executestage/DecodeExecute \
sim:/executestage/inCtrlSignals \
sim:/executestage/WriteBack \
sim:/executestage/ExecuteMemory \
sim:/executestage/ALURESult1 \
sim:/executestage/ALURESutlt2 \
sim:/executestage/branch \
sim:/executestage/flush \
sim:/executestage/ExMemOut \
sim:/executestage/x \
sim:/executestage/ALURSRC \
sim:/executestage/ALUDEST \
sim:/executestage/FlagsReg \
sim:/executestage/FlagsREGOUT

force -freeze sim:/executestage/DecodeExecute 01000000000100000000000000000011111111111111100010100010 0
force -freeze sim:/executestage/inCtrlSignals 00011010001 0
force -freeze sim:/executestage/WriteBack 000000000000010100000000000000110000010 0
force -freeze sim:/executestage/x 000000000000000 0
force -freeze sim:/executestage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/executestage/rst 1 0
force -freeze sim:/executestage/stall 0 0

run
force -freeze sim:/executestage/rst 0 0
run
force -freeze sim:/executestage/x 011000000001001 0
run