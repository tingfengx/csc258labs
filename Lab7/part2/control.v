/// FSM module control, instantieation is c0
module control(
  input clk, 
  input resetn, 
  input load, 
  input go,
  output reg ld_x, 
  output reg ld_y, 
  output reg ld_color, 
  output reg writeEn);

  reg [2:0] current_state, next_state;

  localparam  LOAD_X = 3'b000,
						LOAD_X_WAIT = 3'b001,
						LOAD_Y_C = 3'b010,
						LOAD_Y_C_WAIT = 3'b011,
						DO_PLOT = 3'b100;
  //reset
  always @(posedge clk) begin
		if (~resetn)
			 current_state <= LOAD_X;
		else
			 current_state <= next_state;
  end
  //state table
  always @(*) 
  begin: state_table
		case (current_state)
			 LOAD_X: next_state = load ? LOAD_X_WAIT : LOAD_X;
			 LOAD_X_WAIT: next_state = load ? LOAD_X_WAIT : LOAD_Y_C;
			 LOAD_Y_C: next_state = go ? LOAD_Y_C_WAIT : LOAD_Y_C;
			 LOAD_Y_C_WAIT: next_state = go ? LOAD_Y_C_WAIT : DO_PLOT;
			 DO_PLOT: next_state = load ? LOAD_X : DO_PLOT;
			 default: next_state = LOAD_X;
		endcase
  end

  always @(*)
  begin
		ld_x = 1'b0;
		ld_y = 1'b0;
		ld_color = 1'b0;
		writeEn = 0;
		case (current_state)
			 LOAD_X: ld_x = 1;
			 LOAD_X_WAIT: ld_x = 1;
			 LOAD_Y_C: begin
						ld_x = 0;
						ld_y = 1;
						ld_color = 1;
			 end
			 LOAD_Y_C_WAIT: begin
						ld_x = 0;
						ld_y = 1;
						ld_color = 1;
			 end
			 DO_PLOT: writeEn = 1;
		endcase
  end
endmodule 