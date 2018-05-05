vsim -gui work.processorfd
# vsim -gui work.processorfd 
# Start time: 12:24:49 on May 04,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.processorfd(processorarch)
# Loading ieee.numeric_std(body)
# Loading work.fetchstage(fetchstagearch)
# Loading work.nbitregister(nbitregister_architecture)
# Loading work.pccontroller(pccontrollerarch)
# Loading work.instrmemory(im)
# Loading work.decodestage(decodestagearch)
# Loading work.registerfile(registerfilearch)
# Loading work.controlunit(controlunitarch)
# Loading work.rom(my_rom)
add wave -r /*
force -freeze sim:/processorfd/stall 0 0
force -freeze sim:/processorfd/reset 0 0
force -freeze sim:/processorfd/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processorfd/int 0 0

force -freeze sim:/processorfd/Branch 0 0
force -freeze sim:/processorfd/rst 1 0

# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processorfd/DecodeStage/RegisterFile
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processorfd/DecodeStage/RegisterFile
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processorfd/DecodeStage/RegisterFile
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processorfd/DecodeStage/RegisterFile
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processorfd/FetchStage/IM
mem load -i C:/Users/Univ/Downloads/TestCase1.mem /processorfd/FetchStage/IM/mem
mem load -i C:/Users/Univ/Documents/Architecture2/ctrlsigs.mem /processorfd/DecodeStage/ControlUnit/r/mem
run
force -freeze sim:/processorfd/rst 0 0
run
run
run


 Loading ieee.std_logic_unsigned(body)
# Loading work.processor(processorarch)
# Loading work.forwardingunit(forwardingunitarch)
# Loading ieee.numeric_std(body)
# Loading work.fetchstage(fetchstagearch)
# Loading work.nbitregister(nbitregister_architecture)
# Loading work.pccontroller(pccontrollerarch)
# Loading work.instrmemory(im)
# Loading work.decodestage(decodestagearch)
# Loading work.registerfile(registerfilearch)
# Loading work.controlunit(controlunitarch)
# Loading work.rom(my_rom)
# Loading work.executestage(executestagearch)
# Loading work.outportcontroller(outportcontrollerarch)
# Loading work.nbitregisterf(nbitregister_architecture)
# Loading work.alu(aluarch)
# Loading work.branchunit(branchunitarch)
# Loading work.memorystage(memorystagearch)
# Loading work.mux4(mux4arch)
# Loading work.mux2(mux2arch)
# Loading work.ram(syncrama)
# Loading work.wbstage(wbstagearch)
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/MemoryStage
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/MemoryStage/MyRam
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/MemoryStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/MemoryStage
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/DecodeStage/RegisterFile
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/DecodeStage/RegisterFile
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/DecodeStage/RegisterFile
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/DecodeStage/RegisterFile
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/FetchStage/IM
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 1  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 1  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
run
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 400 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 400 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 500 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 500 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 600 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 600 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 700 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 700 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 800 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 800 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 900 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 900 ps  Iteration: 3  Instance: /processor/ExecuteStage/ALUUnit
run