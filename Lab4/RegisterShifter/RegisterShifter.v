module RegisterShifter(SW, KEY, LEDR);
	input [9:0] SW; 
	input [3:0] KEY;
	output [7:0] LEDR;
	wire [7:0] loadValue;
	wire clk;
	wire ASR;
	wire reset_n;
	wire Load_n;
	wire ShiftRight;
	
	wire w0;
	wire [7:0] Q;
	
   	assign loadValue[7:0] = SW[7:0];
   	assign reset_n = SW[9];
	assign Load_n = KEY[1];
	assign ShiftRight = KEY[2];
	assign ASR = KEY[3];
	assign clk = KEY[0];
	
	TwoToOneMux M0(
		.x(1'b0), 
		.y(Q[7]), 
		.s(ASR), 
		.m(w0)
	);
    
	ShifterBit s7(
		.load_val(loadValue[7]), 
		.in(w0), 
		.out(Q[7]), 
		.reset_n(reset_n), 
		.clk(clk), 
		.load_n(Load_n), 
		.shift(ShiftRight)
	);
	
	ShifterBit s6(
		.load_val(loadValue[6]), 
		.in(Q[7]), 
		.out(Q[6]), 
		.reset_n(reset_n), 
		.clk(clk),
		.load_n(Load_n), 
		.shift(ShiftRight)
	);

	ShifterBit s5(
		.load_val(loadValue[5]), 
		.in(Q[6]),
		.out(Q[5]),
		.reset_n(reset_n), 
		.clk(clk), 
		.load_n(Load_n), 
		.shift(ShiftRight)
	);
	
	ShifterBit s4(
		.load_val(loadValue[4]), 
		.in(Q[5]), 
		.out(Q[4]), 
		.reset_n(reset_n), 
		.clk(clk), 
		.load_n(Load_n), 
		.shift(ShiftRight)
	);

	ShifterBit s3(
		.load_val(loadValue[3]), 
		.in(Q[4]), 
		.out(Q[3]), 
		.reset_n(reset_n), 
		.clk(clk), 
		.load_n(Load_n), 
		.shift(ShiftRight)
	);

	ShifterBit s2(
		.load_val(loadValue[2]), 
		.in(Q[3]), 
		.out(Q[2]), 
		.reset_n(reset_n), 
		.clk(clk), 
		.load_n(Load_n), 
		.shift(ShiftRight)
	);

	ShifterBit s1(
		.load_val(loadValue[1]), 
		.in(Q[2]), 
		.out(Q[1]), 
		.reset_n(reset_n), 
		.clk(clk), 
		.load_n(Load_n), 
		.shift(ShiftRight)
	);

	ShifterBit s0(
		.load_val(loadValue[0]), 
		.in(Q[1]), 
		.out(Q[0]), 
		.reset_n(reset_n), 
		.clk(clk), 
		.load_n(Load_n), 
		.shift(ShiftRight)
	);

	assign LEDR[7:0] = Q[7:0];
endmodule

module ShifterBit(load_val, in, out, reset_n, clk, load_n, shift);
	input in, load_val, reset_n, clk, load_n, shift;
	output out;
	wire w1, w2;

	TwoToOneMux M0(
		.x(in), 
		.y(out), 
		.s(shift), 
		.m(w1)
	);

	TwoToOneMux M1(
		.x(load_val), 
		.y(w1),
		.s(load_n), 
		.m(w2)
	);

	FlipFlop F0(
		.d(w2), 
		.q(out), 
		.clock(clk), 
		.reset_n(reset_n)
	);
endmodule


module FlipFlop(d, q, clock, reset_n);
	input clock, reset_n;
	input d;
	output q;
	reg q;
	
	always @(posedge clock)
	begin
		if (reset_n == 1'b0)
			q <= 1'b0;
		else
			q <= d;
	end
endmodule

module TwoToOneMux(x, y, s, m);
	input x;
	input y;
	input s;
	output m;
	
	assign m = s ? y : x;
endmodule