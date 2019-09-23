# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns mux4.v

# Load simulation using mux as the top level simulation module.
vsim mux4

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}


# Case when SW[9-8] are set to zero, in this case, out should be u.
force {SW[9]} 0
force {SW[8]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
run 10ns

# Case when SW[9-8] are set to 01, in this case, the output should be v
force {SW[9]} 0
force {SW[8]} 1
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
run 10ns

# Case when SW[9-8] are set to 10, in this case, the output should be w
force {SW[9]} 1
force {SW[8]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns

force {SW[9]} 1
force {SW[8]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
run 10ns

force {SW[9]} 1
force {SW[8]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns

force {SW[9]} 1
force {SW[8]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
run 10ns 

# Case when SW[9-8] are set to 11, in this case, the output should be x
force {SW[9]} 1
force {SW[8]} 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
run 10ns

force {SW[9]} 1
force {SW[8]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
run 10ns

force {SW[9]} 1
force {SW[8]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns

force {SW[9]} 1
force {SW[8]} 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns