module CounterSynchronus(KEY, SW, HEX0, HEX1);
	input [0:0] KEY;   //Clock.
	input [1:0] SW;    //SW[0] for Clear_b, SW[1] for Enable.
	output [6:0] HEX0; 
	output [6:0] HEX1; 
	wire [7:0] wire8bit;
	wire [6:0] T;
	
	assign T[0] = SW[1] & wire8bit[0];
	assign T[1] = T[0] & wire8bit[1];
	assign T[2] = T[1] & wire8bit[2];
	assign T[3] = T[2] & wire8bit[3];
	assign T[4] = T[3] & wire8bit[4];
	assign T[5] = T[4] & wire8bit[5];
	assign T[6] = T[5] & wire8bit[6];
	
	TFlipFlop TFF0(
		.Clk(KEY[0]), 
		.T(SW[0]), 
		.Q(wire8bit[0]), 
		.Clear_n(SW[0])
	);
	TFlipFlop TFF1(
		.Clk(KEY[0]), 
		.T(T[0]), 
		.Q(wire8bit[1]), 
		.Clear_n(SW[0])
	);
	// I will write in this more compact way
	TFlipFlop TFF2(.Clk(KEY[0]), .T(T[1]), .Q(wire8bit[2]), .Clear_n(SW[0]));
	TFlipFlop TFF3(.Clk(KEY[0]), .T(T[2]), .Q(wire8bit[3]), .Clear_n(SW[0]));
	TFlipFlop TFF4(.Clk(KEY[0]), .T(T[3]), .Q(wire8bit[4]), .Clear_n(SW[0]));
	TFlipFlop TFF5(.Clk(KEY[0]), .T(T[4]), .Q(wire8bit[5]), .Clear_n(SW[0]));
	TFlipFlop TFF6(.Clk(KEY[0]), .T(T[5]), .Q(wire8bit[6]), .Clear_n(SW[0]));
	TFlipFlop TFF7(.Clk(KEY[0]), .T(T[6]), .Q(wire8bit[7]), .Clear_n(SW[0]));

	hexDecoder hex0(
		.in(wire8bit[3:0]), 
		.out(HEX0[6:0])
	);
	hexDecoder hex1(
		.in(wire8bit[7:4]), 
		.out(HEX1[6:0])
	);
endmodule

module TFlipFlop(Clk, T, Clear_n, Q);
	input Clk;
	input T;
	input Clear_n;
	output reg Q;

	always @(posedge Clk, negedge Clear_n)
 	begin
		if (Clear_n == 1'b0)
			Q <= 1'b0;
		else if  (T == 1'b1)
			Q <= ~Q;
	end
endmodule


// rewritten for more compact code
module hexDecoder (in, out);
	input [3:0] in;
	reg [6:0] result;
	output [6:0] out;
	always @(*)
	begin
		case (in[3:0])
			4'b0000: result[6:0] = 7'b1000000;
			4'b0001: result[6:0] = 7'b1111001;
			4'b0010: result[6:0] = 7'b0100100;
			4'b0011: result[6:0] = 7'b0110000;
			4'b0100: result[6:0] = 7'b0011001;
			4'b0101: result[6:0] = 7'b0010010;
			4'b0110: result[6:0] = 7'b0000010;
			4'b0111: result[6:0] = 7'b1111000;
			4'b1000: result[6:0] = 7'b0000000;
			4'b1001: result[6:0] = 7'b0010000;
			4'b1010: result[6:0] = 7'b0001000;
			4'b1011: result[6:0] = 7'b0000011;
			4'b1100: result[6:0] = 7'b1000110;
			4'b1101: result[6:0] = 7'b0100001;
			4'b1110: result[6:0] = 7'b0000110;
			4'b1111: result[6:0] = 7'b0001110;
			default: result[6:0] = 7'b1000000;
		endcase
	end
	assign out[6:0] = result[6:0];
endmodule 