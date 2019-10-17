module morse_encoder_main(KEY, SW, LEDR, CLOCK_50);
	input [1:0] KEY;
	input [2:0] SW;
	input CLOCK_50;
	output [9:0] LEDR;
	
	wire [12:0] shift_register_load;
	wire [27:0] divider_count;
	wire enable;
	assign enable = (divider_count == 0) ? 1 : 0;
	
	LUT block0(
		.c(SW[2:0]),
		.m(shift_register_load)
	);
	
	rate_divider block1(
		.clock(CLOCK_50),
		.reset_n(KEY[0]),
		.count(divider_count)
	);
	
	shift_register block2(
		.enable(enable),
		.LoadVal(shift_register_load),
		.reset_n(KEY[0]),
		.Load_n(KEY[1]),
		.clk(CLOCK_50),
		.out(LEDR[0])
	);
endmodule
	
module LUT(c, m);
	input [2:0] c;
	output reg [12:0] m; //output's length is 13 bits
	
	always @(*)
	begin
		case(c[2:0])
			3'b000: m <= 13'b0000000010101;
			3'b001: m <= 13'b0000000000111;
			3'b010: m <= 13'b0000001110101;
			3'b011: m <= 13'b0000111010101;
			3'b100: m <= 13'b0000111011101;
			3'b101: m <= 13'b0011101010111;
			3'b110: m <= 13'b1110111010111;
			3'b111: m <= 13'b0010101110111;
		endcase
	end
	
endmodule

module rate_divider(clock, reset_n, count);
	input reset_n;
	input clock;
	output reg [27:0] count; 

	always @(posedge clock)
	begin
		 if (reset_n == 1'b0)
			  count <= 5 * (10 ** 7) / 2 - 1;
		 else if (count == 0)
			  count <= 5 * (10 ** 7) / 2 - 1;
		 else
			  count <= count - 1;
	end

endmodule

module shift_register(enable, LoadVal,  reset_n, Load_n,  clk, out);
	input enable;
	input reset_n;
	wire ShiftRight;
	input clk;
	input Load_n;
	input [12:0] LoadVal; //connected to LUT
	wire [12:0] Q;
	output out;
	assign out = Q[0];
   
	assign ShiftRight = (enable == 1) ? 1 : 0;
	
	ShifterBit sb12(
		.enable(enable),
		.load_val(LoadVal[12]),
		.in(0),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[12]),
		.clk(clk)
	);
	
	
	
	ShifterBit sb11(
		.enable(enable),
		.load_val(LoadVal[11]),
		.in(Q[12]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[11]),
		.clk(clk)
	);
	
	
	
	
	ShifterBit sb10(
		.enable(enable),
		.load_val(LoadVal[10]),
		.in(Q[11]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[10]),
		.clk(clk)
	);
	
	
	ShifterBit sb9(
		.enable(enable),
		.load_val(LoadVal[9]),
		.in(Q[10]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[9]),
		.clk(clk)
	);
	
	ShifterBit sb8(
		.load_val(LoadVal[8]),
		.in(Q[9]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[8]),
		.clk(clk)
	);
	
	ShifterBit sb7(
		.enable(enable),
		.load_val(LoadVal[7]),
		.in(Q[8]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[7]),
		.clk(clk)
	);
	
	ShifterBit sb6(
		.enable(enable),
		.load_val(LoadVal[6]),
		.in(Q[7]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[6]),
		.clk(clk)
	);

	ShifterBit sb5(
		.enable(enable),
		.load_val(LoadVal[5]),
		.in(Q[6]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[5]),
		.clk(clk)
	);
	
	ShifterBit sb4(
		.enable(enable),
		.load_val(LoadVal[4]),
		.in(Q[5]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[4]),
		.clk(clk)
	);
	
	
	ShifterBit sb3(
		.enable(enable),
		.load_val(LoadVal[3]),
		.in(Q[4]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[3]),
		.clk(clk)
	);



	ShifterBit sb2(
		.enable(enable),
		.load_val(LoadVal[2]),
		.in(Q[3]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[2]),
		.clk(clk)
	);


	ShifterBit sb1(
		.enable(enable),
		.load_val(LoadVal[1]),
		.in(Q[2]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[1]),
		.clk(clk)
	);

	
	ShifterBit sb0(
		.enable(enable),
		.load_val(LoadVal[0]),
		.in(Q[1]),
	   .shift(ShiftRight),
		.load_n(Load_n),
		.reset_n(reset_n),
		.out(Q[0]),
		.clk(clk)
	);
	
endmodule


module ShifterBit(enable, load_val, in, shift, clk, load_n, reset_n, out);
	input load_val; // load_val should be 1 bit for every ShifterBit
	input in; // in is also 1 bit for every ShifterBit.
	input shift;
	input load_n;
	input reset_n;
	input clk;
	input enable;
	output out;
	wire mux1_to_mux2;
	wire data_to_dff;
	
	
	mux2to1 mux1 (
		.x(out),
		.y(in),
		.s(shift),
		.m(mux1_to_mux2)
	);
	
	
	mux2to1 mux2 (
		.x(load_val),
		.y(mux1_to_mux2),
		.s(load_n),
		.m(data_to_dff)
	);
	
	d_flip_flop dff (
		.d(data_to_dff),
		.q(out),
		.clock(clk),
		.reset_n(reset_n),
		.enable(enable)
	);
	
endmodule


module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule

module d_flip_flop(d, clock, q, reset_n, enable);
	// one-bit d flip-flop.
	input d;
	input clock;
	input reset_n;
	input enable;
	output q;
	reg q;
	
	always @(posedge clock, negedge reset_n) // Asynchronous reset from reset_n
	
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else
			q <= d;
	end
	
endmodule