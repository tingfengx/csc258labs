# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns hexdecoder.v

# Load simulation using mux as the top level simulation module.
vsim hexdecoder

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}


# SW[3:0] input, SW[3] SW[2] SW[1] SW[0] for the four places of hex digit xyzw
# HEX0[6:0] output display


# TEST CASE: BA3165 
# B
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 20ns

# A 
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 20 ns

# 3
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 20ns

# 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
run 20ns

# 6
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
run 20ns

# 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
run 20ns
