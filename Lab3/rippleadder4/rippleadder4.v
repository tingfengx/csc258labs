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
