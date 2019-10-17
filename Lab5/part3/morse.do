# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns morse_encoder_main.v

vsim morse_encoder_main

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[0]} 1 0, 0 10ns, 1 20ns
force {CLOCK_50} 0 0, 1 10ns -repeat 20ns
run 40ns

force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1 0, 0 10ns, 1 20ns
force {CLOCK_50} 0 0, 1 1ns -repeat 2ns
run 1000000000ns

