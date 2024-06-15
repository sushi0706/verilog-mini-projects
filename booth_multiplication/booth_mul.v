//full adder
module fa(
	input x,
	input y,
	input cin,
	output sum,
	output cout
	);
	
	assign sum=(x ^ y ^ cin);
	assign cout=((x & y) | ((x ^ y) & cin));
	
endmodule

//8-bit adder
module adder(
	input [7:0] a,
	input [7:0] b,
	output [7:0] sum
	);
	
	wire [7:0] carry;
	
	genvar i;
	
	fa add1(a[0],b[0],1'b0,sum[0],carry[0]);
	generate for(i=1;i<8;i=i+1)
		begin : fa_lb
			fa add(a[i],b[i],carry[i-1],sum[i],carry[i]);
		end
	endgenerate
	
endmodule

//booth_mul subpart
module booth_sub(
	input signed [7:0] m,
	input signed [7:0] q,
	input signed [7:0] acc,
	input q0,
	output reg signed [7:0] q_out,
	output reg signed [7:0] acc_out,
	output reg q0_out
	);
	
	wire [7:0] sum,diff;
	
	adder add(m,acc,sum);
	adder sub((8'd0-m),acc,diff);
	
	always@(*) begin
		if(q[0]==q0) begin
			{acc_out,q_out,q0_out}={acc[7],acc,q};
		end
		else if(q[0]==0 && q0==1) begin
			{acc_out,q_out,q0_out}={sum[7],sum,q};
		end
		else begin
			{acc_out,q_out,q0_out}={diff[7],diff,q};
		end
	end
	
endmodule

//8-bit multiplier
module booth_mul(
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [15:0] out
	);
	
	wire signed [7:0] acc[7:1];
	wire signed [7:0] q[7:1];
	wire [8:1] q0;
	genvar i;
	
	booth_sub sub1(a,b,8'd0,1'b0,q[1],acc[1],q0[1]);
	booth_sub sub2(a,q[1],acc[1],q0[1],q[2],acc[2],q0[2]);
	booth_sub sub3(a,q[2],acc[2],q0[2],q[3],acc[3],q0[3]);
	booth_sub sub4(a,q[3],acc[3],q0[3],q[4],acc[4],q0[4]);
	booth_sub sub5(a,q[4],acc[4],q0[4],q[5],acc[5],q0[5]);
	booth_sub sub6(a,q[5],acc[5],q0[5],q[6],acc[6],q0[6]);
	booth_sub sub7(a,q[6],acc[6],q0[6],q[7],acc[7],q0[7]);
	booth_sub sub8(a,q[7],acc[7],q0[7],out[7:0],out[15:8],q0[8]);
	
endmodule 