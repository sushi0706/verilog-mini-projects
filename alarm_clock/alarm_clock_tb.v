module alarm_clock_tb;

	reg areset;
	reg clk;
	reg [1:0] hr_in_1;
	reg [3:0] hr_in_0;
	reg [3:0] min_in_1;
	reg [3:0] min_in_0;
	reg LD_time;
	reg LD_alarm;
	reg STOP_alarm;
	reg AL_ON;

	wire Alarm;
	wire [1:0] hr_out_1;
	wire [3:0] hr_out_0;
	wire [3:0] min_out_1;
	wire [3:0] min_out_0;
	wire [3:0] sec_out_1;
	wire [3:0] sec_out_0;

 
	alarm_clock uut (.areset(areset), 
						  .clk(clk), 
						  .hr_in_1(hr_in_1), 
						  .hr_in_0(hr_in_0), 
						  .min_in_1(min_in_1), 
						  .min_in_0(min_in_0), 
						  .LD_time(LD_time), 
						  .LD_alarm(LD_alarm), 
						  .STOP_alarm(STOP_alarm), 
						  .AL_ON(AL_ON), 
						  .Alarm(Alarm), 
						  .hr_out_1(hr_out_1), 
						  .hr_out_0(hr_out_0), 
						  .min_out_1(min_out_1), 
						  .min_out_0(min_out_0), 
						  .sec_out_1(sec_out_1), 
						  .sec_out_0(sec_out_0));

	initial begin 
		clk = 0;
		forever #50000000 clk = ~clk;
	end
	initial begin

		areset = 1;
		hr_in_1 = 1;
		hr_in_0 = 0;
		min_in_1 = 1;
		min_in_0 = 9;
		LD_time = 0;
		LD_alarm = 0;
		STOP_alarm = 0;
		AL_ON = 0;

		#1000000000;
		areset = 0;
		hr_in_1 = 0;
		hr_in_0 = 1;
		min_in_1 = 2;
		min_in_0 = 0;
		LD_time = 1;
		LD_alarm = 0;
		STOP_alarm = 0;
		AL_ON = 0; 
 
		#1000000000;
		areset = 0;
		hr_in_1 = 1;
		hr_in_0 = 0;
		min_in_1 = 2;
		min_in_0 = 0;
		LD_time = 0;
		LD_alarm = 1;
		STOP_alarm = 0;
		AL_ON = 1;

		wait(Alarm);
		#1000000000;
		#1000000000;
		#1000000000;
		#1000000000;
		#1000000000;
		#1000000000;
		STOP_alarm = 1;

	end
endmodule 