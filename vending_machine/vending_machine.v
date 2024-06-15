module vending_machine(
	input clk,
	input reset,
	input [1:0] product,
	input [5:0] amount,
	output reg product_1, product_2, product_3,
	output reg [4:0] balance
	);
							  
	parameter select_prod_1=2'b01, select_prod_2=2'b10, select_prod_3=2'b11;
	parameter IDLE=2'b00, RS_5=2'b01, RS_10=2'b10, RS_15=2'b11;
	reg [1:0] state,next_state;
	
	always@(*) begin
		case(state) 
			IDLE: begin
				if(product==select_prod_1) next_state=RS_5;
				else if(product==select_prod_2) next_state=RS_10;
				else if(product==select_prod_3) next_state=RS_15;
				else next_state=IDLE;
			end
			RS_5: begin
				if(product==select_prod_1) next_state=RS_5;
				else if(product==select_prod_2) next_state=RS_10;
				else if(product==select_prod_3) next_state=RS_15;
				else next_state=IDLE;
			end
			RS_10: begin
				if(product==select_prod_1) next_state=RS_5;
				else if(product==select_prod_2) next_state=RS_10;
				else if(product==select_prod_3) next_state=RS_15;
				else next_state=IDLE;
			end
			RS_15: begin
				if(product==select_prod_1) next_state=RS_5;
				else if(product==select_prod_2) next_state=RS_10;
				else if(product==select_prod_3) next_state=RS_15;
				else next_state=IDLE;
			end
			default: next_state=IDLE;
		endcase
	end 
	
	always@(posedge clk) begin
		if(reset) state<=IDLE;
		else state<=next_state;
	end
	
	always@(*) begin
		case(state) 
			IDLE: begin
				product_1=1'b0;
				product_2=1'b0;
				product_3=1'b0;
				balance=amount;
			end
			RS_5: begin
				if(amount>=5'd5) begin
					product_1=1'b1;
					product_2=1'b0;
					product_3=1'b0;
					balance=amount-4'd5;
					$display("thanks for buying");
				end else begin
					product_1=1'b0;
					product_2=1'b0;
					product_3=1'b0;
					balance=amount;
					$display("not enough money");
				end
			end
			RS_10: begin
				if(amount>=5'd10) begin
					product_1=1'b0;
					product_2=1'b1;
					product_3=1'b0;
					balance=amount-4'd10;
					$display("thanks for buying");
				end else begin
					product_1=1'b0;
					product_2=1'b0;
					product_3=1'b0;
					balance=amount;
					$display("not enough money");
				end
			end
			RS_15:begin
				if(amount>=5'd15) begin
					product_1=1'b0;
					product_2=1'b0;
					product_3=1'b1;
					balance=amount-4'd15;
					$display("thanks for buying");
				end else begin
					product_1=1'b0;
					product_2=1'b0;
					product_3=1'b0;
					balance=amount;
					$display("not enough money");
				end
			end
			default:begin
				product_1=1'b0;
				product_2=1'b0;
				product_3=1'b0;
				balance=amount;
			end
		endcase
	end 
	
endmodule 