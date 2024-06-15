module voting_machine_tb;
	
	reg clk;
	reg reset;
	reg [1:0] mode;
	reg in_candidate_1, in_candidate_2, in_candidate_3;
	
	wire [7:0] count_candidate_1, count_candidate_2, count_candidate_3;
	wire candidate_1, candidate_2, candidate_3;
	
	voting_machine uut(.clk(clk),
							 .reset(reset),
							 .mode(mode),
							 .in_candidate_1(in_candidate_1),
							 .in_candidate_2(in_candidate_2),
							 .in_candidate_3(in_candidate_3),
							 .count_candidate_1(count_candidate_1),
							 .count_candidate_2(count_candidate_2),
							 .count_candidate_3(count_candidate_3),
							 .candidate_1(candidate_1),
							 .candidate_2(candidate_2),
							 .candidate_3(candidate_3));
							 
	initial begin
		clk=0;
	end
	
	always begin
		#5;
		clk = ~clk;
	end
							 
	initial begin
		reset=1;
		mode=0;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=1; in_candidate_2=0; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=1;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=1; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=1; in_candidate_2=0; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=1; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=1; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=1; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=1;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=1; in_candidate_2=0; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=1; in_candidate_2=0; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=1; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=1;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=1;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=1; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=1; in_candidate_2=0; in_candidate_3=0;
	
		#10;
		reset=0;
		mode=1;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=1;
	
		#10;
		reset=0;
		mode=2;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=0;
		
		#10;
		reset=0;
		mode=2;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=0;
		
		#10;
		reset=0;
		mode=0;
		in_candidate_1=0; in_candidate_2=0; in_candidate_3=0;
	end
	
endmodule
	