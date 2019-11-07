module datapath(
	input clk, resetn, ld_x, ld_y, ld_color,
	input [2:0] color_in,
	input [6:0] coordinate, 
	output [7:0] x_out, 
	output [6:0] y_out, 
	output [2:0] color_out
	);

	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] color;
	reg [3:0] counter;

	//reset or load
	always @(posedge clk) begin
		if (!resetn) begin
			x <= 8'b0;
			y <= 7'b0;
			color <= 3'b0;
		end
		else begin
			if (ld_x)
				x <= {1'b0, coordinate};
			if (ld_y)
				y <= coordinate;
			if (ld_color)
				color <= color_in;
		end
	end
	//counter
	always @(posedge clk) begin
		if (!resetn)
			counter <= 4'b0000;
		else
			if (counter == 1111)
				counter <= 4'b0000;
			else
				counter <= counter + 1'b1;
	end

	assign x_out = x + counter[1:0];
	assign y_out = y + counter[3:2];
	assign color_out = color;
endmodule 