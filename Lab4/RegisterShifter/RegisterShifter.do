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

# SW7-0 value to be loaded
# SW9 synchronus active low reset
# KEY1 load_n, whether or not to load
# KEY2 Shiftright
# KEY3 ASR
# KEY0 CLK



force {SW[9]} 0 0, 1 5, 0 100, 1 105
force {SW[7: 0]} 10101010 0, 10101010 100
force {KEY[0]} 0 0, 1 5 -r 10
force {KEY[1]} 0 10, 1 20, 0 110, 1 120
force {KEY[2]} 0 0, 1 20 -r 100
force {KEY[3]} 0 0, 1 100
run 200ns
