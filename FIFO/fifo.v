module fifo #(parameter WIDTH=8, DEPTH=8)(
	input clk,
	input reset,
	input write,
	input read,
	input [WIDTH-1:0] data_in,
	output reg [WIDTH-1:0] data_out,
	output full,
	output empty
	);
	
	reg [WIDTH-1:0] FIFO[DEPTH-1:0];
	reg [2:0] wr_ptr;
	reg [2:0] rd_ptr;
	
	always@(posedge clk) begin
		if(reset) begin
			data_out<=8'bx;
			wr_ptr<=0;
			rd_ptr<=0;
		end
		else begin
			if(write) begin
				if(!full) begin
					FIFO[wr_ptr]<=data_in;
					wr_ptr<=wr_ptr+1;
				end
				else begin
					$display("overflow");
				end
			end
			if(read) begin
				if(!empty) begin
					data_out<=FIFO[rd_ptr];
					rd_ptr<=rd_ptr+1;
				end
				else begin
					$display("underflow");
				end
			end
		end
	end 
	
	assign full = (wr_ptr + 1 == rd_ptr) ? 1'b1 : 1'b0;
	assign empty = (rd_ptr == wr_ptr) ? 1'b1 : 1'b0;
	
endmodule 
