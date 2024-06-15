module alarm_clock(
  input clk,				//10Hz clock 
  input areset,			        //Asynchronous reset
  input [1:0] hr_in_1,	    		//Most significant input hour digit
  input [3:0] hr_in_0,	    		//Least significant input hour digit
  input [3:0] min_in_1,	  		//Most significant input minute digit
  input [3:0] min_in_0,	  		//Least significant input minute digit
  input LD_alarm,		        //signal to set alarm
  input LD_time,			//signal to set time 
  input STOP_alarm, 		    	//signal to stop alarm
  input AL_ON,			        //signal if alarm function is enable or not
  output [1:0] hr_out_1,	 	//Most significant output hour digit
  output [3:0] hr_out_0,   		//Least significant output hour digit
  output [3:0] min_out_1,  		//Most significant output minute digit
  output [3:0] min_out_0,  		//Least significant output minute digit
  output [3:0] sec_out_1,  		//Most significant output second digit
  output [3:0] sec_out_0,  		//Least significant output second digit
  output reg Alarm);		    	//alarm signal
						 
	reg [5:0] hr_temp, min_temp, sec_temp; 
	reg [1:0] hr_al_1, hr_curr_1;
	reg [3:0] hr_al_0, hr_curr_0;
	reg [3:0] min_al_1, min_curr_1;
	reg [3:0] min_al_0, min_curr_0;
	reg [3:0] sec_al_1, sec_curr_1;
	reg [3:0] sec_al_0, sec_curr_0;
	reg clk_1s;
	reg [3:0] count_1s;
	
	function [3:0] mod_10;
		input [5:0] number;
		begin
			mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
		end
	endfunction

	always@(posedge clk_1s,posedge areset) begin
		if(areset) begin
			hr_al_1<=2'b00;
			hr_al_0<=4'b0000;
			min_al_1<=4'b0000;
			min_al_0<=4'b0000;
			sec_al_1<=4'b0000;
			sec_al_0<=4'b0000;
			hr_temp<=6'b000000;
			min_temp<=6'b000000;
			sec_temp<=6'b000000;
		end
		else begin
			if(LD_alarm) begin
				hr_al_1<=hr_in_1;
				hr_al_0<=hr_in_0;
				min_al_1<=min_in_1;
				min_al_0<=min_in_0;
				sec_al_1<=4'b0000;
				sec_al_0<=4'b0000;
			end
			if(LD_time) begin
				hr_temp<=hr_in_1*10+hr_in_0;
				min_temp<=min_in_1*10+min_in_0;
				sec_temp<=6'b000000;
			end
			else begin
				if(sec_temp==59 & min_temp==59) begin
					hr_temp<=(hr_temp==23)?0:hr_temp+1;
					sec_temp<=0;
					min_temp<=0;
				end
				else if(sec_temp==59) begin
					min_temp<=min_temp+1;
					sec_temp<=0;
				end
				else sec_temp<=sec_temp+1;
			end
		end
	end
	
	always@(*) begin
		if(hr_temp>=20) hr_curr_1 = 2;
		else if(hr_temp >=10) hr_curr_1 = 1;
		else hr_curr_1 = 0;
		hr_curr_0 = hr_temp - hr_curr_1*10; 
		min_curr_1 = mod_10(min_temp); 
		min_curr_0 = min_temp - min_curr_1*10;
		sec_curr_1 = mod_10(sec_temp);
		sec_curr_0 = sec_temp - sec_curr_1*10; 
	end
	
	always@(posedge clk_1s,posedge areset) begin
		if(areset) Alarm<=0;
		else begin
			if({hr_curr_1,hr_curr_0,min_curr_1,min_curr_0}=={hr_al_1,hr_al_0,min_al_1,min_al_0}) begin
				if(AL_ON) Alarm<=1;
				if(STOP_alarm) Alarm<=0;
			end
		end
	end
	
	always@(posedge clk,posedge areset) begin
		if(areset) begin
			count_1s<=0;
			clk_1s<=0;
		end
		else begin
			count_1s<=count_1s+1;
			if(count_1s==5) begin
				clk_1s <= ~clk_1s;
				count_1s<=0;
			end
		end
	end
	
	assign hr_out_1 = hr_curr_1;
	assign hr_out_0 = hr_curr_0;
	assign min_out_1 = min_curr_1;
	assign min_out_0 = min_curr_0;
	assign sec_out_1 = sec_curr_1;
	assign sec_out_0 = sec_curr_0;
	
endmodule 
