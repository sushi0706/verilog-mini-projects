`timescale 1ns/1ns
`include "asy_fifo.v"
module asy_fifo_tb;

    parameter WIDTH = 8, DEPTH = 16;

    reg wr_clk;
    reg rd_clk;
    reg reset;
    reg write;
    reg read;
    reg [WIDTH-1:0] data_in;

    wire [WIDTH-1:0] data_out;
    wire full;
    wire empty;

    integer i;
    integer j;

    asy_fifo uut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .reset(reset),
        .read(read),
        .write(write),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    always #5 wr_clk = ~wr_clk;

    always #7 rd_clk = ~rd_clk;

    task write_data(input [WIDTH-1:0] data);
        begin
            @(negedge wr_clk);
            data_in = data;
            write = 1;
            @(negedge wr_clk);
            write = 0;
        end
    endtask

    task read_data();
        begin
            @(negedge rd_clk);
            read = 1;
            @(negedge rd_clk);
            read = 0;
        end
    endtask

    initial begin
      write = 1'b0;
      read = 1'b0;
      wr_clk = 1'b0;
      rd_clk = 1'b0;
      reset = 1;
    
      #20 reset = 0;
        
      write_data(8'hA1);
      write_data(8'hB2);
      write_data(8'hC3);
      write_data(8'hD4);
        
      read_data();
      read_data();
        
      write_data(8'hE5);
      write_data(8'hF6);

      read_data();
      read_data();
      read_data();

      repeat (DEPTH) write_data($random);

      repeat (DEPTH) read_data();

      #50; $finish;
    end

    initial begin
        $dumpfile("asy_fifo_wave.vcd");
        $dumpvars(0,asy_fifo_tb);
    end

endmodule
