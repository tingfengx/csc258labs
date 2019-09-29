# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns mux71.v

# Load simulation using mux as the top level simulation module.
vsim mux71

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {SW[9]} 0 0, 1 512
force {SW[8]} 0 0, 1 256 -r 512
force {SW[7]} 0 0, 1 128 -r 256
force {SW[6]} 0 0, 1 64 -r 128
force {SW[5]} 0 0, 1 32 -r 64
force {SW[4]} 0 0, 1 16 -r 32
force {SW[3]} 0 0, 1 8 -r 16
force {SW[2]} 0 0, 1 4 -r 8
force {SW[1]} 0 0, 1 2 -r 4
force {SW[0]} 0 0, 1 1 -r 2
run 1024ns