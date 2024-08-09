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

    localparam POINTER = 4;

    reg [WIDTH-1:0] FIFO[DEPTH-1:0];
    
    reg [POINTER-1:0] wr_ptr_bin;
    wire [POINTER-1:0] wr_ptr_gray;
    reg [POINTER-1:0] wr_ptr_sync1, wr_ptr_sync2;
    wire [POINTER-1:0] wr_ptr_sync;
    reg [POINTER-1:0] rd_ptr_bin;
    wire [POINTER-1:0] rd_ptr_gray;
    reg [POINTER-1:0] rd_ptr_sync1, rd_ptr_sync2;
    wire [POINTER-1:0] rd_ptr_sync;

    // read logic
    always @(posedge rd_clk) begin
        if(reset) begin
            data_out <= 8'bx;
            rd_ptr_bin <= 0;
        end else begin
            if(read) begin
                if(empty!==1) begin
                    data_out <= FIFO[rd_ptr_bin];
                    rd_ptr_bin <= rd_ptr_bin + 1;
                end else $display("time=%0t -> underflow",$time);
            end
        end
    end

    // synchronize read pointer into write clock domain
    always @(posedge wr_clk) begin
        rd_ptr_sync1 <= rd_ptr_gray;
        rd_ptr_sync2 <= rd_ptr_sync1;
    end

    // write logic
    always @(posedge wr_clk) begin
        if(reset) begin
            wr_ptr_bin <= 0;
        end else begin
            if(write) begin
                if(full!==1) begin
                    FIFO[wr_ptr_bin] <= data_in;
                    wr_ptr_bin <= wr_ptr_bin + 1;
                end else $display("time=%0t -> overflow",$time);
            end
        end
    end

    // synchronize write pointer into read clock domain
    always @(posedge rd_clk) begin
        wr_ptr_sync1 <= wr_ptr_gray;
        wr_ptr_sync2 <= wr_ptr_sync1;
    end

    // binary to gray code
    assign rd_ptr_gray = rd_ptr_bin ^ (rd_ptr_bin >> 1);
    assign wr_ptr_gray = wr_ptr_bin ^ (wr_ptr_bin >> 1);

    //gray code to binary
    assign rd_ptr_sync = rd_ptr_sync2 ^ (rd_ptr_sync2 >> 1) ^ (rd_ptr_sync2 >> 2) ^ (rd_ptr_sync2 >> 3);
    assign wr_ptr_sync = wr_ptr_sync2 ^ (wr_ptr_sync2 >> 1) ^ (wr_ptr_sync2 >> 2) ^ (wr_ptr_sync2 >> 3);

    // full and empty flags
    assign empty = (rd_ptr_bin == wr_ptr_sync);
    assign full = (wr_ptr_bin + 1 == rd_ptr_sync);

endmodule
