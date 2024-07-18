`include "lfsr.v"
`timescale 1ns/1ns
module lsfr_tb;

  parameter DATA_WIDTH = 5;

  reg clk;
  reg enable;
  reg load;
  reg [DATA_WIDTH-1:0] data_in;
    
  wire [DATA_WIDTH-1:0] data_out;
  wire done;

  lfsr uut(
      .clk(clk),
      .enable(enable),
      .load(load),
      .data_in(data_in),
      .data_out(data_out),
      .done(done)
  );

  initial begin
    clk = 0;
    enable = 1;
    load = 1;
    data_in = 5'b10110;
    #20;
    load = 0;
    #50;
    wait(done);
    $finish;
  end

  initial begin
    $dumpfile("lfsr_test.vcd");
    $dumpvars(0,lsfr_tb);
  end
  
  always begin
    #10;
    clk = ~clk;
  end

endmodule