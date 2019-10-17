# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns eight_bit_counter_main.v

vsim eight_bit_counter_main

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
run 120ns


force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1 0, 0 10ns -repeat 20ns
run 1200ns


