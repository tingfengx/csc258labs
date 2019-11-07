module test_comb(
	input clk, resetn, load, go,
	input [2:0] color_in,
	input [6:0] coordinate,
	output [7:0] x_out,
	output [6:0] y_out,
	output [2:0] color_out
	);

	wire ld_x, ld_y, ld_color, writeEn;

	control c0(
		.clk(clk),
		.resetn(resetn),
		.load(load),
		.go(go),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_color(ld_color),
		.writeEn(writeEn)	
	);

	datapath d0(
		.clk(clk),
		.color_in(color_in[2:0]),
		.resetn(resetn),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_color(ld_color),
		.coordinate(coordinate[6:0]),
		.x_out(x_out),
		.y_out(y_out),
		.color_out(color_out)
	);
    
endmodule