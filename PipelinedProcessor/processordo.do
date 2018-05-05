vsim -gui work.processor


add wave -r /*

mem load -i C:/Users/Univ/Downloads/TestCase1.mem /processor/FetchStage/IM/mem

mem load -i C:/Users/Univ/Documents/Architecture2/ctrlsigs.mem /processor/DecodeStage/ControlUnit/r/mem

force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/int 0 0
force -freeze sim:/processor/rst 1 0
force -freeze sim:/processor/portInput 0000000000000001 0

run

force -freeze sim:/processor/rst 0 0

run


run
run

run

run

run

run

run

run