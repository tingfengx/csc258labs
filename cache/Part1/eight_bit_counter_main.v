module eight_bit_counter_main(SW, KEY, HEX0, HEX1);
	input [9:0]SW;
	input [3:0]KEY;
	output [6:0]HEX0;
	output [6:0]HEX1;
	
	wire [7:0]Q;
	
	eight_bit_counter main0(
		.enable(SW[1]),
		.clear_b(SW[0]),
		.clock(KEY[0]),
		.Q(Q)
	);
	
	seven_segment_decoder main1(
		.c(Q[7:4]),
		.m(HEX1[6:0])
	);
	
	seven_segment_decoder main2(
		.c(Q[3:0]),
		.m(HEX0[6:0])
	);
	
endmodule
	
	
module seven_segment_decoder(c,m);
	input [3:0]c;
	output [6:0]m;
	assign m[0]=(~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0])|(c[3]&c[2]&~c[1]&c[0])|(c[3]&~c[2]&c[1]&c[0]);
	assign m[1]=(~c[3]&c[2]&~c[1]&c[0])|(c[3]&c[2]&~c[0])|(c[3]&c[1]&c[0])|(c[2]&c[1]&~c[0]);
	assign m[2]=(c[3]&c[2]&~c[0])|(c[3]&c[2]&c[1])|(~c[3]&~c[2]&c[1]&~c[0]);
	assign m[3]=(~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0])|(c[2]&c[1]&c[0])|(c[3]&~c[2]&c[1]&~c[0]);
	assign m[4]=(~c[3]&c[0])|(~c[3]&c[2]&~c[1])|(~c[2]&~c[1]&c[0]);
	assign m[5]=(~c[3]&~c[2]&c[0])|(~c[3]&c[1]&c[0])|(~c[3]&~c[2]&c[1])|(c[3]&c[2]&~c[1]&c[0]);
	assign m[6]=(~c[3]&~c[2]&~c[1])|(c[3]&c[2]&~c[1]&~c[0])|(~c[3]&c[2]&c[1]&c[0]);

endmodule


module eight_bit_counter(enable, clock, clear_b, Q);
	input enable;
	input clock;
	input clear_b;
	output [7:0]Q;
	
	wire tff7_to_6;
	wire tff6_to_5;
	wire tff5_to_4;
	wire tff4_to_3;
	wire tff3_to_2;
	wire tff2_to_1;
	wire tff1_to_0;
	wire tff0_out;
	// We don't need ~Q output for our tff methods.
	t_flip_flop block7(
		.T(enable),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[0])
	);
	assign tff7_to_6 = enable & Q[0];
	t_flip_flop block6(
		.T(tff7_to_6),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[1])
	);
	assign tff6_to_5 = tff7_to_6 & Q[1];
	t_flip_flop block5(
		.T(tff6_to_5),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[2])
	);
	assign tff5_to_4 = tff6_to_5 & Q[2];
	t_flip_flop block4(
		.T(tff5_to_4),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[3])
	);
	assign tff4_to_3 = tff5_to_4 & Q[3];
	t_flip_flop block3(
		.T(tff4_to_3),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[4])
	);
	assign tff3_to_2 = tff4_to_3 & Q[4];
	t_flip_flop block2(
		.T(tff3_to_2),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[5])
	);
	assign tff2_to_1 = tff3_to_2 & Q[5];
	t_flip_flop block1(
		.T(tff2_to_1),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[6])
	);
	assign tff1_to_0 = tff2_to_1 & Q[6];
	t_flip_flop block0(
		.T(tff1_to_0),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[7])
	);
	assign tff0_out = Q[7];
	
endmodule

module t_flip_flop(T, clock, clear_b, Q, not_Q);
	input T;
	input clock;
	input clear_b;
	output Q;
	output not_Q;
	
	wire dff_input;
	assign dff_input = (T & not_Q) | (~T & Q);
	

	
	d_flip_flop block1(
		.d(dff_input),
		.clock(clock),
		.q(Q),
		.reset_n(clear_b)
	);
	
	assign not_Q = ~Q;
	
	
endmodule

module d_flip_flop(d, clock, q, reset_n);
	// onebit d flip-flop.
	input d;
	input clock;
	input reset_n;
	output q;
	reg q;

	always @(posedge clock, negedge reset_n)
	
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else
			q <= d;
	end
	
endmodule