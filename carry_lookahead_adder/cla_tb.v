`timescale 1ns/1ns
module cla_tb;

	reg [3:0] a;
	reg [3:0] b;
	reg carry_in;
	
	wire [3:0] sum;
	wire carry_out;
	
	carry_lookahead_adder cla(
		.a(a),
		.b(b),
		.carry_in(carry_in),
		.sum(sum),
		.carry_out(carry_out)
		);
		
		initial begin
			repeat(10) begin
				#10;
				a=$urandom_range(15);
				b=$urandom_range(15);
				carry_in=$urandom_range(1);
			end
			$finish();
		end
		
endmodule 