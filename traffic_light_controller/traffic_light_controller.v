module traffic_light_controller(input clk, output reg red, green, yellow);

	parameter RED=2'b00, GREEN=2'b01, YELLOW=2'b10;
	reg [1:0] state=RED;
	
	always@(posedge clk) begin
		case(state) 
			RED:state<=GREEN;
			GREEN:state<=YELLOW;
			YELLOW:state<=RED;
			default:state<=RED;
		endcase
	end
	
	always@(posedge clk) begin
		red<=(state==RED);
		yellow<=(state==YELLOW);
		green<=(state==GREEN);
	end
	
endmodule 