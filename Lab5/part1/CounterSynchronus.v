module CounterSynchronus(SW, KEY, HEX0, HEX1);
	// main module
	input [1:0]SW;
	input [0:0] KEY;
	output [6:0] HEX0;
	output [6:0] HEX1;
	
	wire [7:0] twohex;
	
	counter8(
		.enable(SW[1]), 	// if incre
		.clk(KEY[0]),  	// clock signal
		.clear_b(SW[0]), 	// reset
		.Q(twohex)
	);
	
	// lower four bits
	hex hex0(twohex[3:0], HEX0);
	// upper four bits
	hex hex1(twohex[7:4], HEX1);
	
endmodule

module counter8(enable, clk, clear_b, Q);
	input enable, clk, clear_b;
	output [7:0] Q;
	
	// seven 'and' parts of the circuit
	wire w0, w1, w2, w3, w4, w5, w6;
	assign w0 = (enable & Q[0]);
	assign w1 = (w0 & Q[1]);
	assign w2 = (w1 & Q[2]);
	assign w3 = (w2 & Q[3]);
	assign w4 = (w3 & Q[4]);
	assign w5 = (w4 & Q[5]);
	assign w6 = (w5 & Q[6]);
	
	// Connecting the flip flops
	TFlipFlop t0(enable, clk, clear_b, Q[0]);
	TFlipFlop t1(w0, clk, clear_b, Q[1]);
	TFlipFlop t2(w1, clk, clear_b, Q[2]);
	TFlipFlop t3(w2, clk, clear_b, Q[3]);
	TFlipFlop t4(w3, clk, clear_b, Q[4]);
	TFlipFlop t5(w4, clk, clear_b, Q[5]);
	TFlipFlop t6(w5, clk, clear_b, Q[6]);
	TFlipFlop t7(w6, clk, clear_b, Q[7]);
	
endmodule	

// Not to name this t_f_f
module TFlipFlop(T, clk, clear_b, Q);
	input T;
	input clk;
	input clear_b;
	output reg Q;
	always @(posedge clk, negedge clear_b)
	begin
		if (clear_b == 1'b0)
			Q <= 1'b0;
		else if (clear_b == 1'b1)
			Q <= ~Q;
	end
endmodule

// Rewritten shorter version of hexdecoder
// The previes version was too cumbersome
// 	to include in pdf reports
module hex(in, out);
	input [3:0] in;
	output [6:0] out;
	reg [6:0] z;
	always @(*)
	begin
		case (in[3:0])
			4'b0000: z = 7'b1111110;
			4'b0001: z = 7'b0110000;
			4'b0010: z = 7'b1101101; 
			4'b0011: z = 7'b1111001;
			4'b0100: z = 7'b0110011;
			4'b0101: z = 7'b1011011;  
			4'b0110: z = 7'b1011111;
			4'b0111: z = 7'b1110000;
			4'b1000: z = 7'b1111111;
			4'b1001: z = 7'b1111011;
			4'b1010: z = 7'b1110111; 
			4'b1011: z = 7'b0011111;
			4'b1100: z = 7'b1001110;
			4'b1101: z = 7'b0111101;
			4'b1110: z = 7'b1001111;
			4'b1111: z = 7'b1000111;
		endcase
	end
	assign out[6:0] = z[6:0];
endmodule 