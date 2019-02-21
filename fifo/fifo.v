module sync_fifo (
    input  wire       clk,     
    input  wire       reset,   
    input  wire       write_en,
    input  wire       read_en, 
    input  wire [7:0] data_in, 
    output reg  [7:0] data_out,
    output       full,       
    output         empty      
);
    reg [7:0] mem [0:7];

    reg [2:0] wr_ptr;   
    reg [2:0] rd_ptr;   
    reg [3:0] count;    

    always @(posedge clk) begin
        if (reset) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
                  end else begin
            if (write_en && !full) begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1;   
                count <= count + 1;
            end

            if (read_en && !empty) begin
                data_out <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;           
                count <= count - 1;
            end

         end
    end
    assign full  = (count == 8);
    assign       empty = (count == 0);

endmodule

