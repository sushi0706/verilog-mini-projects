`include "barrel_shifter.v"
`timescale 1ns/1ns
module barrel_shifter_tb;

    reg [7:0] in;
    reg [2:0] shift_amt;

    wire [7:0] out;

    barrel_shifter uut(
        .in(in),
        .shift_amt(shift_amt),
        .out(out)
    );

    integer i;

    initial begin
        for(i = 0 ; i < 10 ; i = i + 1) begin
            in = $urandom_range(255);
            shift_amt = $urandom_range(7);
            #20;
        end
    end

    initial begin
        $dumpfile("shift.vcd");
        $dumpvars(0, barrel_shifter_tb);
    end

endmodule