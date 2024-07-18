module lfsr #(parameter DATA_WIDTH = 5)(
    input clk,
    input enable,
    input load,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out,
    output done
);

  reg [DATA_WIDTH:1] LFSR;
  reg fb_xnor;

  always @(*) begin
    case(DATA_WIDTH)
      3: fb_xnor = LFSR[3] ^~ LFSR[2];
      4: fb_xnor = LFSR[4] ^~ LFSR[3];
      5: fb_xnor = LFSR[5] ^~ LFSR[3];
      6: fb_xnor = LFSR[6] ^~ LFSR[5];
      7: fb_xnor = LFSR[7] ^~ LFSR[6];
      8: fb_xnor = LFSR[8] ^~ LFSR[6] ^~ LFSR[5] ^~ LFSR[4];
      9: fb_xnor = LFSR[9] ^~ LFSR[5];
      10: fb_xnor = LFSR[10] ^~ LFSR[7];
      11: fb_xnor = LFSR[11] ^~ LFSR[9];
      12: fb_xnor = LFSR[12] ^~ LFSR[6] ^~ LFSR[4] ^~ LFSR[1];
      13: fb_xnor = LFSR[13] ^~ LFSR[4] ^~ LFSR[3] ^~ LFSR[1];
      14: fb_xnor = LFSR[14] ^~ LFSR[5] ^~ LFSR[3] ^~ LFSR[1];
      15: fb_xnor = LFSR[15] ^~ LFSR[14];
      16: fb_xnor = LFSR[16] ^~ LFSR[15] ^~ LFSR[13] ^~ LFSR[4];
      17: fb_xnor = LFSR[17] ^~ LFSR[14];
      18: fb_xnor = LFSR[18] ^~ LFSR[11];
      19: fb_xnor = LFSR[19] ^~ LFSR[6] ^~ LFSR[2] ^~ LFSR[1];
      20: fb_xnor = LFSR[20] ^~ LFSR[17];
      21: fb_xnor = LFSR[21] ^~ LFSR[19];
      22: fb_xnor = LFSR[22] ^~ LFSR[21];
      23: fb_xnor = LFSR[23] ^~ LFSR[18];
      24: fb_xnor = LFSR[24] ^~ LFSR[23] ^~ LFSR[22] ^~ LFSR[17];
      25: fb_xnor = LFSR[25] ^~ LFSR[22];
      26: fb_xnor = LFSR[26] ^~ LFSR[6] ^~ LFSR[2] ^~ LFSR[1];
      27: fb_xnor = LFSR[27] ^~ LFSR[5] ^~ LFSR[2] ^~ LFSR[1];
      28: fb_xnor = LFSR[28] ^~ LFSR[25];
      29: fb_xnor = LFSR[29] ^~ LFSR[27];
      30: fb_xnor = LFSR[30] ^~ LFSR[6] ^~ LFSR[4] ^~ LFSR[1];
      31: fb_xnor = LFSR[31] ^~ LFSR[28];
      32: fb_xnor = LFSR[32] ^~ LFSR[22] ^~ LFSR[2] ^~ LFSR[1];
    endcase
  end

  always @(posedge clk) begin
    if(enable) begin
      if(load) LFSR <= data_in;
      else LFSR <= {LFSR[DATA_WIDTH-1:1], fb_xnor};
    end
  end

  assign data_out = LFSR;
  assign done = (LFSR == data_in);

endmodule