module vending_machine_tb;

	reg clk;
	reg reset;
	reg [5:0] amount;
	reg [1:0] product;
	
	wire product_1, product_2, product_3;
	wire [4:0]  balance;
	
	vending_machine uut(.clk(clk),
							  .reset(reset),
							  .amount(amount),
							  .product(product),
							  .product_1(product_1), .product_2(product_2), .product_3(product_3),
							  .balance(balance));
	
	initial begin
		clk=0;
	end
	
	always begin
		#5; 
		clk = ~clk;
	end
	
	initial begin
		reset=1;
		amount=5'd0;
		product=2'd0;
		
		repeat(5) begin
			#20;
			reset=0;
			amount=5'd5;
			product=2'b01;
		
			#30;
			reset=0;
			amount=5'd5;
			product=2'b10;
		
			#30;
			reset=0;
			amount=5'd10;
			product=2'b10;
		
			#20;
			reset=0;
			amount=5'd20;
			product=2'b10;
		
			#20;
			reset=0;
			amount=5'd10;
			product=2'b11;
		
			#30;
			reset=0;
			amount=5'd20;
			product=2'b11;
		end
	end 
	
endmodule 