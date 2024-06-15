`timescale 1 ps/1 ps

module sequence_detector_tb;

reg clock = 0, exp_out = 0, flag = 1;
reg [2:0] j = 3'b000;
reg [3:0] str[19:0];
reg [3:0] number;

integer i = 0;

wire out;

sequence_detector dut(clock, number, out);
 
localparam [2:0] S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

initial begin
	str[0]  = 7; str[1]  = 5; str[2]  = 1; str[3]  = 0; str[4]  = 9;
	str[5]  = 4; str[6]  = 1; str[7]  = 0; str[8]  = 9; str[9]  = 4;
	str[10] = 3; str[11] = 1; str[12] = 0; str[13] = 9; str[14] = 2;
	str[15] = 1; str[16] = 0; str[17] = 9; str[18] = 4; str[19] = 8;
end

always begin
	clock = 0; #100;
	clock = 1; #100;
end

always @ (negedge clock) begin
	number = str[i];
	if (i == 19) i = 0;
	else i = i + 1;
end

always @ (posedge clock) begin
	case (j)
		S0: begin
			if(number == 1) j = S1;
			else j = S0;
			exp_out = 0;
		end

		S1 : begin
			if(number == 0) j = S2;
			else if(number == 1) j = S1;
			else j = S0;
			exp_out = 0;
		end

		S2 : begin
			if(number == 9) j = S3;
			else if(number == 1) j = S1;
			else j = S0;
			exp_out = 0;
		end

		S3 : begin
			if(number == 4) begin
				j = S4;
				exp_out = 1;
			end
			else if(number == 1) j = S1;
			else j = S0;
		end

		S4 : begin
			if(number == 1) j = S1;
			else j = S0;
			exp_out = 0;
		end
	endcase
end

always begin
	#50;
	if(out !== exp_out) flag = 0;
end

endmodule