module barrel_shifter #(parameter WIDTH=8)(
    input [WIDTH-1:0] in,
    input [2:0] shift_amt,
    output reg [WIDTH-1:0] out
);

    always @(*) begin
        case(shift_amt)
            3'b000: out = in;
            3'b001: out = {1'b0, in[7:1]};
            3'b010: out = {{2{1'b0} }, in[7:2]};
            3'b011: out = {{3{1'b0} }, in[7:3]};
            3'b100: out = {{4{1'b0} }, in[7:4]};
            3'b101: out = {{5{1'b0} }, in[7:5]};
            3'b110: out = {{6{1'b0} }, in[7:6]};
            3'b111: out = {{7{1'b0} }, in[7:7]};
        endcase
    end

endmodule