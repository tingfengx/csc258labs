vlib work 
vlog -timescale 1ns/1ns part2.v vga_adapter.v vga_address_translator.v vga_controller.v vga_pll.v
vsim part2


log {/*}
add wave {CLOCK_50}
add wave {reset}
add wave {KEY}
add wave {SW}
add wave {ld_x}
add wave {ld_y}
add wave {writeEn}
add wave {x}
add wave {y}
add wave {colour}
force {CLOCK_50} 0 0, 1 5 -r 10
force {reset} 0 0, 1 10
force {SW[9]} 1 0
force {SW[8]} 0 0
force {SW[7]} 1 0
force {SW[6]} 0 0
force {SW[5]} 0 0
force {SW[4]} 1 0
force {SW[3]} 1 0
force {SW[2]} 0 0
force {SW[1]} 0 0 
force {SW[0]} 0 0 
force {KEY[3]} 1 0, 0 20, 1 30
force {KEY[1]} 1 0, 0 50, 1 60
run 200ns
