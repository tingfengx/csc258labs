//SW[3:0] data inputs
//SW[9] and SW[8] select signal

//LEDR[0] output display

module mux4(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
	 // declare two wires that connects mux2to1's
    wire w1;
	wire w2;
	 // Left top mux2to1
    mux2to1 u1(
	    .x(SW[0]),
		.y(SW[2]),
		.s(SW[9]),
		.m(w1));
	 // left bottom mux2to1
	 mux2to1 u2(
        .x(SW[1]),
		.y(SW[3]),
		.s(SW[9]),
		.m(w2));
	 // right mux2to1
	 mux2to1 u3(
		.x(w1),
		.y(w2),
		.s(SW[8]),
		.m(LEDR[0])); // final output
endmodule

// This is borrowed from the mux.v file available on quercus
module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule
