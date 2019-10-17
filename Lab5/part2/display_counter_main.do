# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns display_counter_main.v

vsim display_counter_main

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {SW[8]} 0
force {SW[9]} 0
force {SW[0]} 1
force {SW[1]} 1
force {CLOCK_50} 0 0, 1 10ns -repeat 20ns
run 40ns

# 1ps = 0.001ns

force {SW[8]} 1
force {SW[9]} 1
force {SW[0]} 1
force {SW[1]} 1
force {CLOCK_50} 0 0, 1 1ns -repeat 2ns
run 100000000ns

force {SW[8]} 1
force {SW[9]} 1
force {SW[0]} 0
force {SW[1]} 0
force {CLOCK_50} 0 0, 1 1ns -repeat 2ns
run 100000000ns

