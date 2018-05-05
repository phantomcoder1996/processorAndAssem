vsim -gui work.decodestage
# vsim -gui work.decodestage 
# Start time: 06:48:19 on May 03,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.decodestage(decodestagearch)
# Loading work.registerfile(registerfilearch)
# Loading work.controlunit(controlunitarch)
# Loading work.rom(my_rom)
# Loading work.nbitregister(nbitregister_architecture)
add wave  \
sim:/decodestage/clk \
sim:/decodestage/reset \
sim:/decodestage/int \
sim:/decodestage/ack \
sim:/decodestage/branch \
sim:/decodestage/updated \
sim:/decodestage/rst \
sim:/decodestage/FetchDecode \
sim:/decodestage/WriteBack \
sim:/decodestage/WriteBackCtrlSignals \
sim:/decodestage/nextStageEn \
sim:/decodestage/DecodeExecuteIn \
sim:/decodestage/DecodeExecuteOut \
sim:/decodestage/DecExEn \
sim:/decodestage/stall\
sim:/decodestage/LDM\
sim:/decodestage/incrementedPC \
sim:/decodestage/opcode \
sim:/decodestage/Rsrc \
sim:/decodestage/Rdst \
sim:/decodestage/Address_Imm \
sim:/decodestage/WBRSrc \
sim:/decodestage/WBRDst \
sim:/decodestage/RdstData \
sim:/decodestage/RsrcData\
sim:/decodestage/decodedSrcData \
sim:/decodestage/decodedDstData \
sim:/decodestage/decodedCtrlSignals

mem load -i C:/Users/Univ/Documents/Architecture2/ctrlsigs.mem /decodestage/ControlUnit/r/mem
force -freeze sim:/decodestage/WriteBack 000000011000000111000000000000000000101 0
force -freeze sim:/decodestage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/decodestage/reset 0 0
force -freeze sim:/decodestage/int 0 0
force -freeze sim:/decodestage/ack 0 0
force -freeze sim:/decodestage/rst 1 0
force -freeze sim:/decodestage/FetchDecode 0000000010001101001010000000000000000 0
force -freeze sim:/decodestage/WriteBackCtrlSignals 001 0
force -freeze sim:/decodestage/stall 0 0
force -freeze sim:/decodestage/nextStageEn 0 0
run
force -freeze sim:/decodestage/rst 0 0
run
force -freeze sim:/decodestage/WriteBack 000000011100000001110000000000000000100 0
force -freeze sim:/decodestage/FetchDecode 0000000011011101101000010100000000000 0
force -freeze sim:/decodestage/WriteBackCtrlSignals 011 0
run