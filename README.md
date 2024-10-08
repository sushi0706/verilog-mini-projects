# Verilog Mini Projects
This repository currently consists of 10 mini projects.  
## FIFO
### Synchronous FIFO
#### Module
```
module fifo #(parameter WIDTH=8, DEPTH=8)(
	input clk,
	input reset,
	input write,
	input read,
	input [WIDTH-1:0] data_in,
	output reg [WIDTH-1:0] data_out,
	output full,
	output empty
	);
```
#### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/09cb816c-5607-417b-9ea9-61c036733d91)

### Asynchronous FIFO
#### Module
```
module asy_fifo #(parameter WIDTH=8, DEPTH=16)(
    input rd_clk,
    input wr_clk,
    input reset,
    input read,
    input write,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,
    output full,
    output empty
);
```
#### Waveform
![image](https://github.com/user-attachments/assets/4f104b62-c438-465d-b537-315a83cd33d2)


## LFSR
### Module
```
module lfsr #(parameter DATA_WIDTH = 5)(
    input clk,
    input enable,
    input load,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out,
    output done
);
```
### Waveform
![image](https://github.com/user-attachments/assets/368d3d9e-3b91-4d4d-9002-9bf0b913be0d)

## Alarm Clock
### Module
```
module alarm_clock(
  input clk,				//10Hz clock 
 input areset,			        //Asynchronous reset
 input [1:0] hr_in_1,	    		//Most significant input hour digit
 input [3:0] hr_in_0,	    		//Least significant input hour digit
 input [3:0] min_in_1,	  		//Most significant input minute digit
 input [3:0] min_in_0,	  		//Least significant input minute digit
 input LD_alarm,		        //signal to set alarm
 input LD_time,			        //signal to set time 
 input STOP_alarm, 		    	//signal to stop alarm
 input AL_ON,			        //signal if alarm function is enable or not
 output [1:0] hr_out_1,	  		//Most significant output hour digit
 output [3:0] hr_out_0,   		//Least significant output hour digit
 output [3:0] min_out_1,  		//Most significant output minute digit
 output [3:0] min_out_0,  		//Least significant output minute digit
 output [3:0] sec_out_1,  		//Most significant output second digit
 output [3:0] sec_out_0,  		//Least significant output second digit
 output reg Alarm);		    	//alarm signal
```
### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/721c51b0-e9d3-4f41-9940-d46b65515245)  

## Barrel Shifter
### Module
```
module barrel_shifter #(parameter WIDTH=8)(
    input [WIDTH-1:0] in,
    input [2:0] shift_amt,
    output reg [WIDTH-1:0] out
);
```
### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/9b91efcb-0783-49b4-819b-2b400e36b551)

## Booth Multiplier
### Module
```
module booth_mul(
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [15:0] out
	);
```
### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/94743bc3-ce1e-486a-9488-d1257bec1130)  

## Carry Lookahead Adder
### Module
```
module carry_lookahead_adder(
	input [3:0] a,
	input [3:0] b,
	input carry_in,
	output [3:0] sum,
	output carry_out
	);
```
### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/17ab2f82-3ef0-45f3-b7a7-61285b69e389)  

## Sequence Detector
### Module
```
module sequence_detector(
  input clk,
  input [3:0] in,
  output out);
```
### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/4e7d6c11-227f-46fc-a408-26b1607b3ce6)  

## Traffic Light Controller
### Module
```
module traffic_light_controller(
  input clk,
  output reg red,
  green,
  yellow);
```
### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/5cb53a2d-4765-4e55-9185-96938bdab883)  

## Vending Machine
### Module
```
module vending_machine(
	input clk,
	input reset,
	input [1:0] product,
	input [5:0] amount,
	output reg product_1, product_2, product_3,
	output reg [4:0] balance
	);
```
### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/cb64ffaf-59db-471d-9321-324599456b2e)  

## Voting Machine
### Module
```
module voting_machine(
	 input clk,
	 input reset,
	 input [1:0] mode,
	 input in_candidate_1,
	 input in_candidate_2,
	 input in_candidate_3,
	 output [7:0] count_candidate_1,
	 output [7:0] count_candidate_2,
	 output [7:0] count_candidate_3,
	 output candidate_1,
	 output candidate_2,
	 output candidate_3);
```
### Waveform
![image](https://github.com/sushi0706/verilog-mini-projects/assets/170224108/31ff08fe-cd77-4844-a668-3ce257fb0554)
