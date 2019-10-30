# Set the working dir, where all compiled Verilog goes.
vlib work
vlog -timescale 1ns/1ns poly_function.v

vsim poly_function

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {KEY[0]} 1 0, 0 2ns, 1 4ns
force {CLOCK_50} 0 0, 1 1 -repeat 2ns
run 40ns

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[1]} 1 0, 0 2ns, 1 4ns, 0 6ns, 1 8ns, 0 10ns, 1 12ns, 0 14ns, 1 16ns, 0 18ns, 1 20ns, 0 22ns, 1 24ns
force {CLOCK_50} 0 0, 1 1ns -repeat 2ns
run 100ns

force {KEY[0]} 1 0, 0 2ns, 1 4ns
force {CLOCK_50} 0 0, 1 1 -repeat 2ns
run 40ns

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1 0, 0 2ns, 1 4ns, 0 6ns, 1 8ns, 0 10ns, 1 12ns, 0 14ns, 1 16ns, 0 18ns, 1 20ns, 0 22ns, 1 24ns
force {CLOCK_50} 0 0, 1 1ns -repeat 2ns
run 100ns

force {KEY[0]} 1 0, 0 2ns, 1 4ns
force {CLOCK_50} 0 0, 1 1 -repeat 2ns
run 40ns

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
force {KEY[1]} 1 0, 0 2ns, 1 4ns, 0 6ns, 1 8ns, 0 10ns, 1 12ns, 0 14ns, 1 16ns, 0 18ns, 1 20ns, 0 22ns, 1 24ns
force {CLOCK_50} 0 0, 1 1ns -repeat 2ns
run 100ns

force {KEY[0]} 1 0, 0 2ns, 1 4ns
force {CLOCK_50} 0 0, 1 1 -repeat 2ns
run 40ns

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 1 0, 0 2ns, 1 4ns, 0 6ns, 1 8ns, 0 10ns, 1 12ns, 0 14ns, 1 16ns, 0 18ns, 1 20ns, 0 22ns, 1 24ns
force {CLOCK_50} 0 0, 1 1ns -repeat 2ns
run 100ns
