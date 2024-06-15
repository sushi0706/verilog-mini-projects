module sequence_detector(input clk,
								 input [3:0] in,
								 output out);
		
	parameter IDLE=3'b000, ONE=3'b001, ZERO=3'b010, NINE=3'b011, FOUR=3'b100;
	reg [2:0] state=IDLE,next_state;
	
	always@(*) begin
		case(state) 
			IDLE:next_state=(in==4'd1)?ONE:IDLE;
			ONE:next_state=(in==4'd0)?ZERO:((in==4'd1)?ONE:IDLE);
			ZERO:next_state=(in==4'd9)?NINE:((in==4'd1)?ONE:IDLE);
			NINE:next_state=(in==4'd4)?FOUR:((in==4'd1)?ONE:IDLE);
			FOUR:next_state=(in==4'd1)?ONE:IDLE;
			default:next_state=IDLE;
		endcase
	end
	
	always@(posedge clk) begin
		state<=next_state;
	end
	
	assign out=(state==FOUR);
	
endmodule 