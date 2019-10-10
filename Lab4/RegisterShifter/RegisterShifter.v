module RegisterShifter(SW, KEY, LEDR);
	input [9:0] SW; // SW8 Unused
	input [3:0] KEY;
	output [7:0] LEDR;
	
	ShifterUnit8 s(
		// SW7-0: LoadVal
		.LoadVal(SW[7:0]),
		// KEY[1] Load_n
		.Load_n(KEY[1]),
		// KEY[2] ShifterRight
		.ShiftRight(KEY[2]),
		// KEY[3] ASR
		.ASR(KEY[3]),
		// KEY[0] Clock Signal
		.clk(KEY[0]),
		// Reset or not
		.reset_n(SW[9]),
		.q(LEDR[7:0])
	);
endmodule


// 8 bit shifter module
module ShifterUnit8(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, q);
	input [7:0] LoadVal;
	input Load_n, ShiftRight, ASR, clk, reset_n;
	output [7:0] q;
	
	wire w0;
	
	ASRController asr0(
		.asr(ASR),
		.first(LoadVal[7]),
		.m(w0)
	);
	
	ShifterBit s7(
		.load_val(LoadVal[7]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(w0),
		.out(q[7])
	);
	
	ShifterBit s6(
		.load_val(LoadVal[6]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[7]),
		.out(q[6])
	);
	
	ShifterBit s5(
		.load_val(LoadVal[5]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[6]),
		.out(q[5])
	);
	
	ShifterBit s4(
		.load_val(LoadVal[4]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[5]),
		.out(q[4])
	);
	
	ShifterBit s3(
		.load_val(LoadVal[3]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[4]),
		.out(q[3])
	);
	
	ShifterBit s2(
		.load_val(LoadVal[2]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[3]),
		.out(q[2])
	);
	
	ShifterBit s1(
		.load_val(LoadVal[1]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[2]),
		.out(q[1])
	);
	
	ShifterBit s0(
		.load_val(LoadVal[0]),
		.load_n(Load_n),
		.shift(ShiftRight),
		.clk(clk),
		.reset_n(reset_n),
		.in(q[1]),
		.out(q[0])
	);

endmodule

// Acts like a mux for ASR or not
module ASRController(asr, first, m);
	input asr, first;
	output m;
	reg m;
	always @(*)
	begin
		if (asr == 1'b1)
			m = first;
		else
			m = 1'b0;
	end
endmodule


module ShifterBit(load_val, load_n, clk, reset_n, shift, in, out);
	input load_val, load_n, clk, reset_n, shift, in;
	output out;
	wire w0;
	wire w1;
	
	mux m0(
		.x(out),
		.y(in),
		.s(shift),
		.m(w0)
	);
	
	mux m1(
		.x(load_val),
		.y(w0),
		.s(load_n),
		.m(w1)
	);
	
	DFlipFlop d0(
		.d(w1),
		.clk(clk),
		.r(reset_n),
		.q(out)
	);

endmodule


module DFlipFlop(d, clk, r, q);
	input d, clk;
	input r;
	output q;
	
	reg q;
	
	always @(posedge clk)
	begin
		// If reset_n == 0: reset the flip flop
		if (r == 1'b0)
			q <= 1'b0;
		// transparent d-flipflop
		else
			q <= d;
	end
endmodule


module mux(x, y, s, m);
    input x;
    input y;
    input s;
    output m;
  
    assign m = s & y | ~s & x;
endmodule