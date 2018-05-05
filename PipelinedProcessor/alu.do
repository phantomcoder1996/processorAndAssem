
vsim -gui work.alu
# vsim -gui work.alu 
# Start time: 12:40:24 on Apr 19,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.alu(aluarch)
add wave -position insertpoint sim:/alu/*
force -freeze sim:/alu/ALUSrc1 1111111111111111 0
force -freeze sim:/alu/ALUSrc2 1111111111111111 0
force -freeze sim:/alu/opcode 00010 0
run

force -freeze sim:/alu/opcode 00100 0
run


force -freeze sim:/alu/ALUSrc1 1111111111111111 0
force -freeze sim:/alu/ALUSrc2 1111111111111111 0
force -freeze sim:/alu/opcode 00010 0
run

force -freeze sim:/alu/opcode 00100 0
run

force -freeze sim:/alu/ALUSrc1 0100000000000000 0
force -freeze sim:/alu/ALUSrc2 0100000000000000 0
force -freeze sim:/alu/opcode 00010 0
run


force -freeze sim:/alu/ALUSrc1 1111111111111111 0

force -freeze sim:/alu/ALUSrc2 1111111111111111 0

force -freeze sim:/alu/opcode 00010 0

run

force -freeze sim:/alu/opcode 00100 0

run


force -freeze sim:/alu/ALUSrc1 0100000000000000 0

run


force -freeze sim:/alu/ALUSrc1 1111111111111111 0
force -freeze sim:/alu/ALUSrc2 1111111111111111 0
force -freeze sim:/alu/opcode 00010 0
run

force -freeze sim:/alu/opcode 00100 0
run

force -freeze sim:/alu/ALUSrc1 0100000000000000 0
force -freeze sim:/alu/ALUSrc2 0100000000000000 0
force -freeze sim:/alu/opcode 00010 0
run

force -freeze sim:/alu/ALUSrc1 1100000000000000 0
force -freeze sim:/alu/ALUSrc2 1100000000000000 0
run

force -freeze sim:/alu/opcode 01001 0
force -freeze sim:/alu/ALUSrc2 0000000000000001 0
run
force -freeze sim:/alu/ALUSrc1 0100000000000000 0
run
force -freeze sim:/alu/ALUSrc1 1100000000000000 0
run
force -freeze sim:/alu/ALUSrc1 1000000000000000 0
run
run

force -freeze sim:/alu/opcode 01001 0
 
force -freeze sim:/alu/ALUSrc2 0000000000000001 0
force -freeze sim:/alu/ALUSrc1 0100000000000000 0
run

force -freeze sim:/alu/opcode 01001 0

force -freeze sim:/alu/ALUSrc2 0000000000000001 0
force -freeze sim:/alu/ALUSrc1 0100000000000000 0
run


force -freeze sim:/alu/opcode 01001 0

force -freeze sim:/alu/ALUSrc2 0000000000000001 0
force -freeze sim:/alu/ALUSrc1 0100000000000000 0
run

force -freeze sim:/alu/ALUSrc2 0000000000000010 0
run
run

force -freeze sim:/alu/opcode 01001 0

force -freeze sim:/alu/ALUSrc2 0000000000000001 0
force -freeze sim:/alu/ALUSrc1 0100000000000000 0
run

force -freeze sim:/alu/ALUSrc2 0000000000000010 0
run
force -freeze sim:/alu/opcode 01010 0
run

force -freeze sim:/alu/opcode 00011 0
force -freeze sim:/alu/ALUSrc1 1111111111111111 0
force -freeze sim:/alu/ALUSrc2 0000000000000010 0
run

force -freeze sim:/alu/ALUSrc1 0000000000000000 0
run


force -freeze sim:/alu/ALUSrc1 0111111111111111 0
force -freeze sim:/alu/ALUSrc2 0000000000001000 0

force -freeze sim:/alu/opcode 00011 0
run

force -freeze sim:/alu/opcode 00101 0
force -freeze sim:/alu/ALUSrc1 1111000011110000 0
force -freeze sim:/alu/ALUSrc2 1010010110100101 0
run

force -freeze sim:/alu/opcode 00110 0
run

force -freeze sim:/alu/opcode 10011 0
force -freeze sim:/alu/ALUSrc1 0000100001001000 0
force -freeze sim:/alu/ALUSrc2 0000100000001000 0
run

force -freeze sim:/alu/opcode 10100 0
run

force -freeze sim:/alu/opcode 11001 0
run
force -freeze sim:/alu/opcode 11010 0
run

run
force -freeze sim:/alu/opcode 11011 0
run

force -freeze sim:/alu/opcode 10011 0
force -freeze sim:/alu/ALUSrc1 0000100001001000 0
force -freeze sim:/alu/ALUSrc2 0000100000001000 0
run


