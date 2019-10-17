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
	
	hex block2(
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

// Rewritten shorter version of hexdecoder
// The previes version was too cumbersome
// 	to include in pdf reports
module hex(c, m);
	input [3:0] c;
	output [6:0] m;
	reg [6:0] z;
	always @(*)
	begin
		case (c[3:0])
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
	assign m[6:0] = z[6:0];
endmodule 