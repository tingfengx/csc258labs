 # Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns RegisterShifter.v

# Load simulation using mux as the top level simulation module.
vsim RegisterShifter

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}



#1
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[3]} 0
force {KEY[2]} 1      
force {KEY[1]} 0   
force {KEY[0]} 1
force {SW[9]} 0   
run 10ns
#2
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[3]} 0
force {KEY[2]} 1      
force {KEY[1]} 0   
force {KEY[0]} 0
force {SW[9]} 1   
run 10ns
#3
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 0
force {KEY[2]} 0      
force {KEY[1]} 0   
force {KEY[0]} 1
force {SW[9]} 1   
run 10ns
#4
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[3]} 0
force {KEY[2]} 0      
force {KEY[1]} 0   
force {KEY[0]} 0
force {SW[9]} 1   
run 10ns
#5
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[3]} 0
force {KEY[2]} 1      
force {KEY[1]} 1   
force {KEY[0]} 1
force {SW[9]} 1   
run 10ns
#6
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[3]} 0
force {KEY[2]} 0      
force {KEY[1]} 0   
force {KEY[0]} 0
force {SW[9]} 1   
run 10ns
#7
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[3]} 0
force {KEY[2]} 1      
force {KEY[1]} 1   
force {KEY[0]} 1
force {SW[9]} 1   
run 10ns
