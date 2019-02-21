module fifo_tb;
    reg clk;
    reg reset;
    reg write_en;
    reg read_en;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire full;
    wire empty;

    sync_fifo uut (
        .clk(clk),
        .reset(reset),
        .write_en(write_en),
        .read_en(read_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    initial clk = 0;
    always #5 clk = ~clk; 
    
    initial begin 
   $shm_open("wave.shm");
   $shm_probe("ACTMF");
   end


    //  for PASS/FAIL
    reg expected_full, expected_empty;

    initial begin
        $display("Time| WR | RD | DIN | DOUT | FULL | EMPTY | RESULT");
        $monitor("%4t | %b | %b | %3d | %3d | %b | %b | %s",
                 $time, write_en, read_en, data_in, data_out,
                 full, empty,
                 ((full === expected_full) && (empty === expected_empty)) ? "PASS" : "FAIL");
    end

    initial begin
        clk = 0; reset = 1; write_en = 0; read_en = 0; data_in = 0;
        expected_full = 0; expected_empty = 1;
        #10; reset = 0;

        // Write till full
         write_en = 1; expected_empty = 0; expected_full = 0;
        data_in = 8'd1; #10;
        data_in = 8'd2; #10;
        data_in = 8'd3; #10;
        data_in = 8'd4; #10;
        data_in = 8'd5; #10;
        data_in = 8'd6; #10;
        data_in = 8'd7; #10;
        data_in = 8'd8; expected_full = 1; #10;
        write_en = 0;

        // Write when full
        write_en = 1; data_in = 8'd99; expected_full = 1; expected_empty = 0; #10;
        write_en = 0;

        //  Read till empty
         read_en = 1; expected_full = 0; expected_empty = 0; #10;
        #10; #10; #10; #10; #10; #10; #10; #10;
        expected_empty = 1; #10; read_en = 0;

        //  Read when empty
         read_en = 1; expected_empty = 1; expected_full = 0; #10;
        read_en = 0;

        // Alternate write/read
         expected_empty = 0; expected_full = 0;
        write_en = 1; data_in = 8'd10; #10;
        write_en = 0; read_en = 1; #10;
        read_en = 0; write_en = 1; data_in = 8'd11; #10;
        write_en = 0; read_en = 1; #10;
        read_en = 0;

        //  Concurrent write/read
         write_en = 1; read_en = 1; data_in = 8'd55;
        expected_empty = 0; expected_full = 0; #10;
        write_en = 0; read_en = 0;

        // Reset during operation
        write_en = 1; data_in = 8'd20; #10;
        reset = 1; expected_full = 0; expected_empty = 1; #10;
        reset = 0; write_en = 0;

        // Pointer wrap-around
         write_en = 1; expected_empty = 0; expected_full = 0;
        data_in = 8'd1; #10;
        data_in = 8'd2; #10;
        data_in = 8'd3; #10;
        data_in = 8'd4; #10;
        data_in = 8'd5; #10;
        data_in = 8'd6; #10;
        data_in = 8'd7; #10;
        data_in = 8'd8; expected_full = 1; #10;
        write_en = 0; read_en = 1; expected_empty = 0; expected_full = 0;
        #10; #10; #10; #10; #10; #10; #10; #10; #10;
        expected_empty = 1; read_en = 0; #10;

        // Random read/write 
         repeat (10) begin
            write_en = $random % 2;
            read_en = $random % 2;
            data_in = $random % 256;
            expected_empty = 0;
            expected_full = 0;  
            #10;
        end
        write_en = 0; read_en = 0; #20;

        $finish;
    end
endmodule

