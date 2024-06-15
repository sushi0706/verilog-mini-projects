module traffic_light_controller_tb;

	reg clk=0;
	wire red,green,yellow;
	
	traffic_light_controller uut(.clk(clk),.red(red),.green(green),.yellow(yellow));
	
	always begin
		clk = ~clk; #10000;
	end
	
endmodule