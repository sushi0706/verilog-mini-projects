module voting_machine(
	 input clk,
	 input reset,
	 input [1:0] mode,
	 input in_candidate_1,
	 input in_candidate_2,
	 input in_candidate_3,
	 output [7:0] count_candidate_1,
	 output [7:0] count_candidate_2,
	 output [7:0] count_candidate_3,
	 output candidate_1,
	 output candidate_2,
	 output candidate_3
);
	
	parameter IDLE=2'b00, CAST_VOTE=2'b01, TALLY_VOTE=2'b10;
	reg [1:0] state, next_state;
	reg [7:0] vote_1, vote_2, vote_3;
	
	always@(*) begin
		case(state) 
			IDLE: begin
				if(mode==2'b01) next_state=CAST_VOTE;
				else if(mode==2'b10) next_state=TALLY_VOTE;
				else next_state=IDLE;
			end
			CAST_VOTE: next_state=IDLE;
			TALLY_VOTE: next_state=IDLE;
			default:next_state=IDLE;
		endcase
	end 
	
	always@(posedge clk) begin
		if(reset)begin
			state<=IDLE;
		end
		else state<=next_state;
	end 
	
	always@(posedge clk) begin
		if(reset) begin
			vote_1<=8'd0;
			vote_2<=8'd0;
			vote_3<=8'd0;
		end
		else begin
			vote_1<=vote_1+in_candidate_1;
			vote_2<=vote_2+in_candidate_2;
			vote_3<=vote_3+in_candidate_3;
		end
	end 
	
	assign candidate_1 = in_candidate_1;
	assign candidate_2 = in_candidate_2;
	assign candidate_3 = in_candidate_3;
	assign count_candidate_1 = (state==TALLY_VOTE) ? vote_1 : 8'd0;
	assign count_candidate_2 = (state==TALLY_VOTE) ? vote_2 : 8'd0;
	assign count_candidate_3 = (state==TALLY_VOTE) ? vote_3 : 8'd0;
	
endmodule 
