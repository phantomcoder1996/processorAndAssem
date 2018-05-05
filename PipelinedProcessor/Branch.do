vsim -gui work.branchunit
# vsim -gui work.branchunit 
# Start time: 16:31:24 on Apr 21,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.branchunit(branchunitarch)
# vsim -gui work.branchunit 
# Start time: 16:26:54 on Apr 21,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.branchunit(branchunitarch)
add wave -position insertpoint sim:/branchunit/*
force -freeze sim:/branchunit/opcode 11000 0
force -freeze sim:/branchunit/DecExAluEn 1 0
force -freeze sim:/branchunit/ALUFlags 0000 0
run
force -freeze sim:/branchunit/opcode 10111 0
run
force -freeze sim:/branchunit/ALUFlags 0100 0
run
run
force -freeze sim:/branchunit/FlagReg 0100 0
run
run
force -freeze sim:/branchunit/DecExAluEn 0 0
force -freeze sim:/branchunit/FlagReg 0000 0
run
force -freeze sim:/branchunit/opcode 10101 0
run
force -freeze sim:/branchunit/FlagReg 1000 0
run