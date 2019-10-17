module display_counter_main(SW, HEX0, CLOCK_50);
	input [9:0] SW;
	input CLOCK_50;
	
	output [6:0] HEX0;
	
	wire enable;
	wire [27:0] RateDivider;
	assign enable = (RateDivider == 28'd0) ? 1 : 0;
	
	wire [3:0] Q;
	
	hex_counter block0(
		.d(SW[6:3]), //Load value
		.clock(CLOCK_50),
		.reset_n(SW[9]),
		.par_load(SW[7]),
		.enable(enable),
		.unpause(SW[8]),
		.q(Q)
	);
	
	rate_divider block1(
		.rate(SW[1:0]),
		.clock(CLOCK_50),
		.reset_n(SW[9]),
		.count(RateDivider)
	);
	
	seven_segment_decoder block2(
		.c(Q[3:0]),
		.m(HEX0[6:0])
	);
endmodule
	


// hex_counter's enable is determined by clock divider.
module hex_counter(d, clock, reset_n, par_load, enable, q, unpause);
	input [3:0] d;
	input clock;
	input reset_n;
	input unpause;
	input par_load, enable;
	output [3:0] q;
	reg [3:0] q;
	
	
	
	always @(posedge clock, negedge reset_n, posedge par_load) //Very important: add negedge reset_n!
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else if (par_load == 1'b1)
			q <= d;
		else if (enable == 1'b1 & unpause == 1'b1)
			begin
				if (q == 4'b1111)
					q <= 0;
				else 
					q <= q + 1'b1;
			end
	end

endmodule
	
module rate_divider(rate, clock, reset_n, count);
	input [1:0] rate;
	input reset_n;
	input clock;
	output [27:0] count;
	reg [27:0] count;
	reg [27:0] scale;
	always @(*)
	begin
	     case (rate[1:0])
		      2'b00: scale = 0;
				2'b01: scale = 1;
				2'b10: scale = 2;
				2'b11: scale = 4;
		  endcase
	end
	 

	always @(posedge clock)
		if (rate[1:0] != 2'b00)
		begin 
			 if (reset_n == 1'b0)
				  count <= 5 * (10 ** 7) * scale - 1;
			 else if (count == 0)
				  count <= 5 * (10 ** 7) * scale - 1;
			 else
				  count <= count - 1;
		end
		else
		    count <= 0;

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