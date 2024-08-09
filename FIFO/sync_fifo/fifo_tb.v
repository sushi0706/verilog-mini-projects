module fifo_tb;

	reg clk;
	reg reset;
	reg write;
	reg read;
	reg [7:0] data_in;
	
	wire [7:0] data_out;
	wire full;
	wire empty;
	
	fifo uut(.clk(clk),
				.reset(reset),
				.write(write),
				.read(read),
				.data_in(data_in),
				.data_out(data_out),
				.full(full),
				.empty(empty));
				
	initial begin
		clk=0;
		forever begin
			#10;
			clk = ~clk;
		end
	end 
	
	initial begin
		reset=1;
		write=0;
		read=0;
		
		#100;
		reset=0;
		write=1;
		data_in=$urandom;
		
		#20;
		data_in=$urandom;
		
		#20;
		data_in=$urandom;
		
		#20;
		write=0;
		read=1;
		
		#20;
		read=1;
		
		#20;
		read=1;
		
		#20;
		read=1;
		
		#20;
		write=1;
		read=0;
		data_in=$urandom;
		
		#20;
		write=0;
		read=1;
		
		#20;
		$finish();
	end
	
endmodule 