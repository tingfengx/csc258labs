# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns CounterSynchronus.v

# Load simulation using mux as the top level simulation module.
vsim CounterSynchronus

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {KEY[0]} 1 0, 0 10 -repeat 20
force {SW[1]} 0 0, 1 10 
force {SW[0]} 0 0, 1 10
run 5120ns
force {KEY[0]} 1 0, 0 10 -repeat 20
force {SW[1]} 0 0, 1 10 
force {SW[0]} 0 
run 100ns
