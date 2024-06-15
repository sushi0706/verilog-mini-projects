//4-bit carry lookahead adder
module carry_lookahead_adder(
	input [3:0] a,
	input [3:0] b,
	input carry_in,
	output [3:0] sum,
	output carry_out
	);
	
	wire p0, p1, p2, p3;			//carry propgate
	wire g0, g1, g2, g3;			//carry generate
	wire c0, c1, c2;				//internal carry
	
	assign p0 = (a[0] ^ b[0]);
	assign p1 = (a[1] ^ b[1]);
	assign p2 = (a[2] ^ b[2]);
	assign p3 = (a[3] ^ b[3]);
	
	assign g0 = (a[0] & b[0]);
	assign g1 = (a[1] & b[1]);
	assign g2 = (a[2] & b[2]);
	assign g3 = (a[3] & b[3]);
	
	assign c0 = (g0 | (p0 & carry_in));
	assign c1 = (g1 | (g0 & p1) | (p0 & p1 & carry_in));
	assign c2 = (g2 | (g1 & p2) | (g0 & p1 & p2) | (p0 & p1 & p2 & carry_in));
	assign carry_out = (g3 | (g2 & p3) | (g1 & p2 & p3) | (g0 & p1 & p2 & p3) | (p0 & p1 & p2 & p3 & carry_in));
	
	assign sum = {p3^c2, p2^c1, p1^c0, p0^carry_in};
	
endmodule	