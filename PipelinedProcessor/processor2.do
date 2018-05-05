vsim -gui work.processor

add wave  \
sim:/processor/clk \
sim:/processor/FetchStage/instrMemOut \
sim:/processor/FetchStage/FetchDecodeIN \
sim:/processor/FetchStage/FetchDecodeOutput \
sim:/processor/FetchStage/FetchDecodeOut \
sim:/processor/DecodeStage/DecodeExecuteIn \
sim:/processor/DecodeStage/DecodeExecuteOut \
sim:/processor/ExecuteStage/ExMemIN \
sim:/processor/ExecuteStage/ExecuteMemory\
sim:/processor/DecodeStage/WriteBackCtrlSignals \
sim:/processor/WBStage/RsrcVal \
sim:/processor/WBStage/RdstVal \
sim:/processor/WBStage/WBSrc \
sim:/processor/WBStage/WBDst \
sim:/processor/DecodeStage/WriteBack \
sim:/processor/DecodeStage/decodedSrcData \
sim:/processor/DecodeStage/decodedDstData \
sim:/processor/ExecuteStage/ALUUnit/ALUSrc1 \
sim:/processor/ExecuteStage/ALUUnit/ALUSrc2 \
sim:/processor/ExecuteStage/ALURESult1 \
sim:/processor/ALUResult2 \
sim:/processor/ExecuteStage/FlagsReg \
sim:/processor/ExecuteStage/WBDstData \
sim:/processor/ExecuteStage/WBSrcData \
sim:/processor/FetchStage/MemoryData \
sim:/processor/FetchStage/pcinput \
sim:/processor/FetchStage/pcoutput \
sim:/processor/ExecuteStage/OutportOutput 


add wave -r /*

mem load -i C:/Users/Univ/Documents/Architecture2/TestCase1.mem /processor/FetchStage/IM/mem

mem load -i C:/Users/Univ/Documents/Architecture2/ctrlsigs.mem /processor/DecodeStage/ControlUnit/r/mem

force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/int 0 0
force -freeze sim:/processor/rst 1 0
force -freeze sim:/processor/portInput 0000000000000001 0

run

force -freeze sim:/processor/rst 0 0
mem load -skip 0 -filltype value -filldata 1111111111111111 -fillradix symbolic -startaddress 6 -endaddress 6 /processor/DecodeStage/RegisterFile/registers
run
run
run
run
run
run

run

run

run
run

run

run

run

run

run

run


run

run

run


run

run

run

run

run

run
run

run
run 

run