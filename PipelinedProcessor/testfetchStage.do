vsim -gui work.fetchstage
# vsim -gui work.fetchstage 
# Start time: 10:02:57 on May 04,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.fetchstage(fetchstagearch)
# Loading work.nbitregister(nbitregister_architecture)
# Loading work.pccontroller(pccontrollerarch)
# Loading work.instrmemory(im)
add wave -position insertpoint  \
sim:/fetchstage/flush
add wave -position insertpoint  \
sim:/fetchstage/clk \
sim:/fetchstage/reset \
sim:/fetchstage/int \
sim:/fetchstage/branch \
sim:/fetchstage/rst \
sim:/fetchstage/ret \
sim:/fetchstage/flush \
sim:/fetchstage/DECEXRET \
sim:/fetchstage/EXECMEMRET \
sim:/fetchstage/x \
sim:/fetchstage/ALUResult1 \
sim:/fetchstage/AlUResult2 \
sim:/fetchstage/MemoryData \
sim:/fetchstage/WBSrcData \
sim:/fetchstage/WBDstData \
sim:/fetchstage/decodedDstData \
sim:/fetchstage/pushIntrEn \
sim:/fetchstage/start \
sim:/fetchstage/FetchDecodeOutput \
sim:/fetchstage/nextStageEn \
sim:/fetchstage/FetDecUSERsrc \
sim:/fetchstage/FetDecUSERdst \
sim:/fetchstage/stall \
sim:/fetchstage/pcinput \
sim:/fetchstage/pcoutput \
sim:/fetchstage/PCen \
sim:/fetchstage/instrMemOut \
sim:/fetchstage/irRst \
sim:/fetchstage/IROut \
sim:/fetchstage/Rsrc \
sim:/fetchstage/Rdst \
sim:/fetchstage/opCode \
sim:/fetchstage/Imm \
sim:/fetchstage/countRst \
sim:/fetchstage/countEn \
sim:/fetchstage/countOut \
sim:/fetchstage/twoWord \
sim:/fetchstage/FetchDecodeIN \
sim:/fetchstage/FetchDecodeOut \
sim:/fetchstage/FetchDecodeEn \
sim:/fetchstage/indicatorBits
force -freeze sim:/fetchstage/flush 0 0
force -freeze sim:/fetchstage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetchstage/reset 0 0
force -freeze sim:/fetchstage/int 0 0
force -freeze sim:/fetchstage/branch 0 0
force -freeze sim:/fetchstage/rst 1 0
force -freeze sim:/fetchstage/ret 0 0
force -freeze sim:/fetchstage/PCen 1 0
force -freeze sim:/fetchstage/stall 0 0
mem load -i C:/Users/Univ/Downloads/TestCase1.mem /fetchstage/IM/mem
run

force -freeze sim:/fetchstage/rst 0 0

run