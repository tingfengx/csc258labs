module ALU(SW, KEY, LEDR, HEX0, HEX2, HEX4, HEX5);
	input [7:0] SW;
	input [2:0] KEY;
	output [6:0] HEX0;
	output [6:0] HEX2;
	output [6:0] HEX4;
	output [6:0] HEX5;
	output [7:0] LEDR;
	// two wires for arithmetic operations
	wire [4:0] addOneToA
	wire [4:0] addAToB;

	// two 4 bit ripple adders 
	rippleadder4 ra1(
		.SW({1'b0, SW[7:4], 4'b0001}), 
		.LEDR(addOneToA[4:0])
	);
	rippleadder4 ra2(
		.SW({1'b0, SW[7:4], SW[3:0]}), 
		.LEDR(addAToB[4:0])
	);

	reg [7:0] ALUout;
	always @(*)
	begin
		case (KEY[2:0])
			3'b000: ALUout[7:0] = {3'b000, addOneToA[4:0]};
			3'b001: ALUout[7:0] = {3'b000, addAToB[4:0]};
			3'b010: ALUout[7:0] = {3'b000, SW[7:4] + SW[3:0]};
			3'b011: ALUout[7:0] = {SW[7:4] | SW[3:0] ? 4'b0001 : 4'b0000, SW[7:4] ^ SW[3:0] ? 4'b0001 : 4'b0000};
			3'b100: ALUout[7:0] = {7'b0000000, (|SW[7:0])};
			3'b101: ALUout[7:0] = SW[7:0];
			default: ALUout[7:0] = 8'b0000_0000;
		endcase
	end
	
	assign LEDR[7:0] = ALUout[7:0];
	hexdecoder hex0(
		.SW(SW[3:0]), 
		.HEX(HEX0[6:0])
	);
	hexdecoder hex2(
		.SW(SW[7:4]), 
		.HEX(HEX2[6:0])
	);

	hexdecoder hex4(
		.SW(ALUout[3:0]), 
		.HEX(HEX4[6:0])
	);    //First four bits
	hexdecoder hex5(
		.SW(ALUout[7:4]), 
		.HEX(HEX5[6:0])
	);    //Second four bits
endmodule

module hexdecoder(HEX, SW);
    input [3:0] SW;
    output [6:0] HEX;

    hex0 u0(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX[0])
	);
	
    hex1 u1(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX[1])
	);
	  
    hex2 u2(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX[2])
	);

    hex3 u3(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX[3])
	);

    hex4 u4(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX[4])
	);

    hex5 u5(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX[5])
	);

    hex6 u6(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX[6])
	;
				
endmodule

module hex0(x, y, z, w, m);
    input x;
    input y;
    input z;
    input w;
    output m;
  
    assign m = (~x & ~y & ~z & w) | (~x & y & ~z & ~w) | (x & y & ~z & w) | (x & ~y & z & w);

endmodule

module hex1(x, y, z, w, m);
    input x;
    input y;
    input z;
    input w;
    output m;
  
    assign m = (~x & y & ~z & w) | (x & z & w) | (y & z & ~w) | (x & y & ~w);

endmodule

module hex2(x, y, z, w, m);
    input x;
    input y;
    input z;
    input w;
    output m;
  
    assign m = (x & y & ~w) | (x & y & z) | (~x & ~y & z & ~w);

endmodule

module hex3(x, y, z, w, m);
    input x;
    input y;
    input z;
    input w;
    output m;
  
    assign m = (~x & y & ~z & ~w) | (~x & ~y & ~z & w) | (y & z & w) | (x & ~y & z & ~w);

endmodule

module hex4(x, y, z, w, m);
    input x;
    input y;
    input z;
    input w;
    output m;
  
    assign m = (~x & w) | (~y & ~z & w) | (~x & y & ~z);

endmodule

module hex5(x, y, z, w, m);
    input x;
    input y;
    input z;
    input w;
    output m;
  
    assign m = (~x & ~y & w) | (~x & ~y & z) | (~x & z & w) |(x & y & ~z & w);

endmodule

module hex6(x, y, z, w, m);
    input x;
    input y;
    input z;
    input w;
    output m;
  
    assign m = (~x & ~y & ~z) | (~x & y & z & w) | (x & y & ~z & ~w);


endmodule

module rippleadder4(SW, LEDR);
	// SW[3:0] number 1
	// SW[7:4] number 2
	// SW[8:8] carry initial
	input [8:0] SW;
	
	output [4:0] LEDR;  // 4 bit result, one bit carry
	// connecting the four full adders
	wire w1;
	wire w2;
	wire w3;
	
	fulladder f1(
		.cin(SW[8]),
		.a(SW[4]),
		.b(SW[0]),
		.cout(w1),
		.s(LEDR[0])
	);
	
	fulladder f2(
		.cin(w1),
		.a(SW[5]),
		.b(SW[1]),
		.cout(w2),
		.s(LEDR[1])
	);
	
	fulladder f3(
		.cin(w2),
		.a(SW[6]),
		.b(SW[2]),
		.cout(w3),
		.s(LEDR[2])
	);
	
	fulladder f4(
		.cin(w3),
		.a(SW[7]),
		.b(SW[3]),
		.cout(LEDR[4]),
		.s(LEDR[3])
	);

endmodule

// full adder
module fulladder(cin, a, b, s, cout);
//	input a;
//	input b;
//	input cin;
//	output s;
//	output cout;
//	
//	assign s = a^b^cin;
//	assign cout = (a & b) | (cin & (a^b));
	input cin;
	input a;
	input b;
	output cout;
	output s;
	
	wire w1;
	
	mux2to1 mux(
		.x(b),
		.y(cin),
		.s(w1),
		.m(cout)
	);
	
	XOR x1(
		.a(a),
		.b(b),
		.f(w1)
	);
	
	XOR x2(
		.a(cin),
		.b(w1),
		.f(s)
	);
endmodule

// define a XOR module
module XOR(a, b, f);
	input a;
	input b;
	output f;
	assign f = a ^ b;
endmodule

// mux2to1 from lab2
module mux2to1(x, y, s, m);
	input x; //selected when s is 0
	input y; //selected when s is 1
	input s; //select signal
	output m; //output
	
	assign m = s & y | ~s & x;
endmodule
