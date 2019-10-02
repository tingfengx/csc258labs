# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns ALU.v

# Load simulation using mux as the top level simulation module.
vsim ALU

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# 000, make the output equal to plus one, 0111 + 1 = 1000
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 0
run 10ns

# 000, make the output equal to plus one, 1111 + 1 = 10000. overflow by one bit
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
run 10ns

# 001, A+B. 0000+1111 = 1111
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
run 10ns

# 001, A+B. 0101+0001 = 0110
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
run 10ns

# 010 verilog + operator 0000+1111 = 1111, same as case 1 in 001
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
run 10ns

# 010 verilog + operator, 0101 + 0001 = 0110, same as case 2 in 001
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
run 10ns

# 011, XOR in the lower bits and OR in higher bits, 1000 and 0111, all one
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
run 10ns

# 011, XOR in the lower bits and OR in higher bits, 0101 and 1111,  OR = 1111 XOR=1010
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
run 10ns

# 100 case where alll zero, 0000_0000
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 10ns

# 100 case where all one, 0000_0001
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
run 10ns

# 100 case where some one, 0000_0001
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
run 10ns

# 101 case apear input,  01001101
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
run 10ns

# 101 case apear input,  1100_1110
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 1
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 1
run 10ns