vlib work
vlog -timescale 1ns/1ns ram32x4.v
vsim -L altera_mf_ver ram32x4
log {/*}
add wave {/*}
force {clock} 0 0ns, 1 10ns -r 20ns

#write
force {wren} 1
force {address} 00000
force {data} 0001
run 20ns
force {address} 01000
force {data} 0010
run 20ns
force {address} 10000
force {data} 0011
run 20ns
force {address} 11000
force {data} 0100
run 20ns

#read
force {wren} 0
force {address} 00000
run 20ns
force {address} 01000
run 20ns
force {address} 10000
run 20ns
# last four slots
force {address} 11100
run 20ns
