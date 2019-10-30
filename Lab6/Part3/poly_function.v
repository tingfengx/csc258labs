//Sw[7:0] data_in

//KEY[0] synchronous reset when pressed

//KEY[1] go signal

//LEDR displays result

//HEX0 & HEX1 also displays result
module poly_function(SW, KEY, CLOCK_50, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input [9:0] SW;
    input [3:0] KEY;
    input CLOCK_50;
    output [9:0] LEDR;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    wire resetn;
    wire go;

    wire [3:0] quotient;
	 wire [4:0] remainder;
    assign go = ~KEY[1];
    assign resetn = KEY[0];

    part2 u0(
        .clk(CLOCK_50),
        .resetn(resetn),
        .go(go),
        .data_in(SW[7:0]),
        .quotient(quotient),
		  .remainder(remainder)
    );
      
    assign LEDR[3:0] = quotient;

    hex_decoder H0(
        .hex_digit(SW[3:0]), 
        .segments(HEX0)
        );
		  
	  hex_decoder H1(
	  .hex_digit(4'b0000), 
	  .segments(HEX1)
	  );
        
    hex_decoder H2(
        .hex_digit(SW[7:4]), 
        .segments(HEX2)
        );
		  
         hex_decoder H3(
        .hex_digit(4'b0000), 
        .segments(HEX3)
        );
		  
		   hex_decoder H4(
        .hex_digit(quotient), 
        .segments(HEX4)
        );
		    hex_decoder H5(
        .hex_digit(remainder[3:0]), 
        .segments(HEX5)
        );


endmodule

module part2(
    input clk,
    input resetn,
    input go,
    input [7:0] data_in,
    output [3:0] quotient,
	 output [4:0] remainder
    );

    // lots of wires to connect our datapath and control
    wire ld_dividend, ld_registerA, dividend_shift, dividend_q0_set, alu_op, ld_r, save_subtracted;
    wire ld_divisor, register_shift, clear;

    control C0(
        .clk(clk),
        .resetn(resetn),
        
        .go(go),
        
        .ld_divisor(ld_divisor), 
        .ld_dividend(ld_dividend),
        .ld_registerA(ld_registerA),
        .dividend_shift(dividend_shift),
        .dividend_q0_set(dividend_q0_set), 
		  .register_shift(register_shift),
        .alu_op(alu_op), 
		  .ld_r(ld_r),
		  .save_subtracted(save_subtracted),
		  .clear(clear)
    );

    datapath D0(
        .clk(clk),
        .resetn(resetn),
        .dividend_in(data_in[7:4]), 
        .divisor_in({1'b0,data_in[3:0]}),
        .ld_registerA(ld_registerA),
        .ld_divisor(ld_divisor),
        .ld_dividend(ld_dividend), 
		  .dividend_shift(dividend_shift),
		  .dividend_q0_set(dividend_q0_set), 
		  .register_shift(register_shift),
        .alu_op(alu_op), 
        //outputs
        .data_result(quotient),
        .registerA(remainder),
		  .ld_r(ld_r),
		  .clear(clear),
		  .save_subtracted(save_subtracted)
    );
                
 endmodule        
module control(
    input clk,
    input resetn,
    input go,

    output reg  ld_divisor, ld_dividend, ld_registerA, ld_r,
	 output reg  dividend_shift, dividend_q0_set, register_shift, save_subtracted,
    output reg  alu_op, clear
    );

    reg [4:0] current_state, next_state; 
    
    localparam  
					 S_START           = 6'd0,
					 S_START_WAIT      = 6'd1,
					 S_CLEAR           = 6'd2,
					 S_LOAD            = 6'd3,
		          S_SHIFT_1         = 6'd4,
					 S_SHIFT_1_DIV     = 6'd5,
					 S_SUBTRACT_1      = 6'd6,
					 S_SUBTRACT_1_SAVE = 6'd7,
				    S_ADD_1           = 6'd8,
					 S_SET_1           = 6'd9,
					 S_SHIFT_2         = 6'd10,
					 S_SHIFT_2_DIV     = 6'd11,
					 S_SUBTRACT_2      = 6'd12,
					 S_SUBTRACT_2_SAVE = 6'd13,
				    S_ADD_2           = 6'd14,
					 S_SET_2           = 6'd15,
					 S_SHIFT_3         = 6'd16,
					 S_SHIFT_3_DIV     = 6'd17,
					 S_SUBTRACT_3      = 6'd18,
					 S_SUBTRACT_3_SAVE = 6'd19,
				    S_ADD_3           = 6'd20,
					 S_SET_3           = 6'd21,
					 S_SHIFT_4         = 6'd22,
					 S_SHIFT_4_DIV     = 6'd23,
					 S_SUBTRACT_4      = 6'd24,
					 S_SUBTRACT_4_SAVE = 6'd25,
				    S_ADD_4           = 6'd26,
					 S_SET_4           = 6'd27,
					 done              = 6'd28;
					
    
    // Next state logic aka our state table
    always@(*)
    begin
            case (current_state)
				    S_START: next_state = go ? S_START_WAIT:S_START;
					 S_START_WAIT: next_state = go ? S_START_WAIT:S_CLEAR;
					 S_CLEAR: next_state = S_LOAD;
                S_LOAD: next_state = S_SHIFT_1; 
                S_SHIFT_1: next_state = S_SHIFT_1_DIV; 
					 S_SHIFT_1_DIV: next_state = S_SUBTRACT_1; 
                S_SUBTRACT_1: next_state = S_SUBTRACT_1_SAVE;
					 S_SUBTRACT_1_SAVE: next_state = S_ADD_1;
					 S_ADD_1: next_state = S_SET_1;
                S_SET_1: next_state = S_SHIFT_2;
                S_SHIFT_2: next_state = S_SHIFT_2_DIV;
					 S_SHIFT_2_DIV: next_state = S_SUBTRACT_2; 
                S_SUBTRACT_2: next_state = S_SUBTRACT_2_SAVE;
					 S_SUBTRACT_2_SAVE: next_state = S_ADD_2;
					 S_ADD_2: next_state = S_SET_2;
                S_SET_2: next_state = S_SHIFT_3;
                S_SHIFT_3: next_state = S_SHIFT_3_DIV;
					 S_SHIFT_3_DIV: next_state = S_SUBTRACT_3; 
                S_SUBTRACT_3: next_state = S_SUBTRACT_3_SAVE;
					 S_SUBTRACT_3_SAVE: next_state = S_ADD_3;
					 S_ADD_3: next_state = S_SET_3;
                S_SET_3: next_state = S_SHIFT_4;
                S_SHIFT_4: next_state = S_SHIFT_4_DIV; 
					 S_SHIFT_4_DIV: next_state = S_SUBTRACT_4; 
                S_SUBTRACT_4: next_state = S_SUBTRACT_4_SAVE;
					 S_SUBTRACT_4_SAVE: next_state = S_ADD_4;
					 S_ADD_4: next_state = S_SET_4;
                S_SET_4: next_state = done;
					 done: next_state = S_START;
            default: next_state = S_START;
        endcase
    end // state_table
   

    // Output logic aka all of our datapath control signals
    always @(*)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    begin: enable_signals
        // By default make all our signals 0
        ld_registerA = 1'b0;
		  save_subtracted = 1'b0;
        ld_divisor = 1'b0;
        ld_dividend = 1'b0;
		  ld_r = 1'b0;
        alu_op       = 1'b0;
		  dividend_shift = 1'b0;
		  dividend_q0_set = 1'b0;
		  register_shift = 1'b0;
		  clear = 1'b0;
        case (current_state)
		      S_CLEAR: clear = 1'b1;
            S_LOAD: begin
                ld_divisor = 1'b1;
					 ld_dividend = 1'b1;
                end
            S_SHIFT_1: begin
                register_shift = 1'b1;
                end
				S_SHIFT_1_DIV: begin
                dividend_shift = 1'b1;
                end
            S_SUBTRACT_1: begin
                alu_op = 1'b0;
					 ld_registerA = 1'b1;
                end
				S_SUBTRACT_1_SAVE:begin
				    save_subtracted = 1'b1;
					 end
            S_ADD_1: begin
                alu_op = 1'b1;
					 ld_registerA = 1'b1;
                end
            S_SET_1: begin
                dividend_q0_set = 1'b1;
                end
				S_SHIFT_2: begin
                register_shift = 1'b1;
                end
            S_SHIFT_2_DIV: begin
                dividend_shift = 1'b1;
                end
            S_SUBTRACT_2: begin
                alu_op = 1'b0;
					 ld_registerA = 1'b1;
                end
				S_SUBTRACT_2_SAVE:begin
				    save_subtracted = 1'b1;
					 end
            S_ADD_2: begin
                alu_op = 1'b1;
					 ld_registerA = 1'b1;
                end
            S_SET_2: begin
                dividend_q0_set = 1'b1;
                end
				S_SHIFT_3: begin
				    register_shift = 1'b1;
				    end
            S_SHIFT_3_DIV: begin
                dividend_shift = 1'b1;
                end
            S_SUBTRACT_3: begin
                alu_op = 1'b0;
					 ld_registerA = 1'b1;
					
                end
				S_SUBTRACT_3_SAVE:begin
				    save_subtracted = 1'b1;
					 end
            S_ADD_3: begin
                alu_op = 1'b1;
					 ld_registerA = 1'b1;
                end
            S_SET_3: begin
                dividend_q0_set = 1'b1;
                end
				S_SHIFT_4: begin
				    register_shift = 1'b1;
				    end
            S_SHIFT_4_DIV: begin
                dividend_shift = 1'b1;
                end
            S_SUBTRACT_4: begin
                alu_op = 1'b0;
					 ld_registerA = 1'b1;
					
                end
				S_SUBTRACT_4_SAVE:begin
				    save_subtracted = 1'b1;
					 end
            S_ADD_4: begin
                alu_op = 1'b1;
					 ld_registerA = 1'b1;
                end
            S_SET_4: begin
                dividend_q0_set = 1'b1;
                end
				done: begin
				    ld_r = 1'b1;
				end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_START;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

module datapath(
    //control unit gonna deal with these inputs.
    input clk,
    input resetn, clear,
    input [3:0] dividend_in,
	 input [4:0] divisor_in,
    input ld_registerA,
    input ld_divisor, ld_dividend,
	 input dividend_shift, //for the dividend
	 input dividend_q0_set,
	 input save_subtracted,
	 input register_shift,
    input alu_op,
	 input ld_r,
    // Register A, which is one of the outputs of the alu
    output reg [4:0] registerA,
	 output reg [3:0] data_result
    );
    reg [3:0] dividend;
    // input registers
    reg [4:0] divisor;
    
	 // output of the alu
	 reg [4:0] alu_out;
	 
	 
    reg [4:0] subtracted;
	 // Register for "subtracted"
	 always @ (posedge clk) begin
        if (!resetn | clear) begin
            subtracted <= 4'd0; 
        end
        else 
            if(save_subtracted)
                subtracted <= registerA;
    end
	 
    // Registers for divisor, dividend, with respective input logic
    always @ (posedge clk) begin
        if (!resetn | clear) begin
		  // restore all the registers。
            divisor <= 5'd0;
				dividend <= 4'b0;
        end
        else begin
            if (ld_divisor)
                divisor <= divisor_in; 
            if (ld_dividend)
                dividend <= dividend_in;
				if (dividend_shift)
				    begin
//				    registerA <= {registerA[4:0], dividend[3]};
					 dividend <= {dividend[2:0], 1'b0};
					 end
				if (dividend_q0_set)
				    begin
					     if(subtracted[4] == 1'b0)
						      dividend[0] <= 1'b1;
						  else
						      dividend[0] <= 1'b0;
					 end
        end
    end
	 
	     // Output result register
    always @ (posedge clk) begin
        if (!resetn | clear) begin
            data_result <= 4'd0; 
        end
        else 
            if(ld_r)
                data_result <= dividend;
    end
 
    // Register A
    always @ (posedge clk) begin
        if (!resetn | clear) 
		      begin
            registerA <= 5'd0; 
            end
        else  
		       if (ld_registerA)
                registerA <= alu_out;
				 if (register_shift)
				    registerA <= {registerA[3:0], dividend[3]};
	 end
    // The ALU 
    always @(*)
    begin : ALU
        // alu
        case (alu_op)
            1'b0: begin
                  alu_out = registerA - divisor; //performs 
                  end
            1'b1: begin
				      if(registerA[4] == 1'b1)
                      alu_out = registerA + divisor; //performs addition
						else
						    alu_out = registerA; // maintain
                  end
            default: alu_out = 5'd0;
        endcase
    end

endmodule


module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule
