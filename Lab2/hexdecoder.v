//SW[3:0] input, SW[3] SW[2] SW[1] SW[0] for the four places of hex digit xyzw
//HEX0[6:0] output display

module hexdecoder(HEX0, SW);
    input [3:0] SW;
    output [6:0] HEX0;

    hex0 u0(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX0[0]));
	
    hex1 u1(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX0[1]));
	  
    hex2 u2(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX0[2]));

    hex3 u3(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX0[3]));

    hex4 u4(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX0[4]));

    hex5 u5(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX0[5]));

    hex6 u6(
        .x(SW[3]),
        .y(SW[2]),
        .z(SW[1]),
        .w(SW[0]),
        .m(HEX0[6]));
				
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