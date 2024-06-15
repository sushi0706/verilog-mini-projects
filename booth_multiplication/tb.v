module tb;

	reg signed [7:0] a;
	reg signed [7:0] b;
	
	wire signed [15:0] out;
	
	booth_mul booth(.a(a),.b(b),.out(out));
	
	initial begin
		repeat(10) begin
			a=$random;
			b=$random;
			#10;
		end
		$finish();
	end
	
endmodule 