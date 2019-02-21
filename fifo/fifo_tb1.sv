module fifo_tb_1;
    reg clk, reset, write_en, read_en;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire full, empty;

    string testname;  

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

    always #5 clk = ~clk;
    initial begin 
   $shm_open("wave.shm");
   $shm_probe("ACTMF");
   end


   initial begin
        $monitor("T=%0t | rst=%b wr=%b rd=%b din=%0d dout=%0d full=%b empty=%b",
                 $time, reset, write_en, read_en, data_in, data_out, full, empty);
     end

    
     task reset_fifo;
        begin
            $display("\n[TEST] Reset FIFO");
            reset = 1; write_en = 0; read_en = 0; data_in = 0;
            @(posedge clk);
            @(posedge clk);
            reset = 0;
            @(posedge clk);
            if (empty && !full)
                $display("PASS: FIFO reset successfully");
            else
                $display("FAIL: FIFO reset failed");
        end
    endtask

    

task write_till_full;
  integer i;
  begin
    $display("\n[TEST] Write till FULL");
    i = 0;
    while (!full && i < 8) begin
      @(posedge clk);
      write_en = 1;
      data_in = i;
      i = i + 1;
    end
    @(posedge clk);
    write_en = 0;
    @(posedge clk); 
    if (full)
      $display("PASS: FIFO full after %0d writes", i);
    else
      $display("FAIL: FIFO not full after %0d writes", i);
  end
endtask
       task write_on_full;
        begin
            $display("\n[TEST] Write on FULL");
            @(posedge clk);
            write_en = 1; data_in = 99;
            @(posedge clk); write_en = 0;
            if (full) $display("PASS: Write blocked on full");
            else $display("FAIL: Write caused overflow");
        end
    endtask

task read_till_empty;
    integer i;
    begin
        $display("\n[TEST] Read till EMPTY");
        i = 0;

        while (!empty) begin
            @(posedge clk);
            read_en = 1;
            i = i + 1;
        end

        @(posedge clk);
        read_en = 0;
        @(posedge clk);

        if (empty)
            $display("PASS: FIFO emptied correctly after %0d reads", i);
        else
            $display("FAIL: FIFO did not empty correctly, empty=%b", empty);
    end
endtask

    
    task read_on_empty;
        begin
            $display("\n[TEST] Read on EMPTY");
            @(posedge clk);
            read_en = 1;
            @(posedge clk); read_en = 0;
            if (empty) $display("PASS: Read blocked on empty");
            else $display("FAIL: Read caused underflow");
        end
    endtask

    task write_read_alternation;
        integer i;
        begin
          @(posedge clk) reset=1;
          @(posedge clk) reset=0;


            $display("\n[TEST] Write-Read Alternation");
            for (i = 0; i < 4; i++) begin
                @(posedge clk);
                write_en = 1; data_in = i + 10;
                @(posedge clk);
                write_en = 0; read_en = 1;
                @(posedge clk);
                read_en = 0;
            end
            $display("PASS: Alternation test done");
        end
    endtask

    task concurrent_write_read;
        integer i;
        begin
            $display("\n[TEST] Concurrent Write/Read");
            for (i = 0; i < 5; i++) begin
                @(posedge clk);
                write_en = 1; read_en = 1; data_in = i + 20;
                @(posedge clk);
            end
            write_en = 0; read_en = 0;
            $display("PASS: Concurrent test done");
        end
    endtask

    task reset_during_operation;
        begin
            $display("\n[TEST] Reset During Operation");
            @(posedge clk);
            write_en = 1; data_in = 55;
            @(posedge clk);
            reset = 1;
            @(posedge clk);
            reset = 0; write_en = 0;
            @(posedge clk);
            if (empty && !full)
                $display("PASS: Reset cleared FIFO mid-operation");
            else
                $display("FAIL: Reset during operation failed");
        end
    endtask

    task pointer_wraparound;
        integer i;
        begin
            $display("\n[TEST] Pointer Wrap-Around");
            for (i = 0; i < 8; i++) begin
                @(posedge clk);
                write_en = 1; data_in = i + 30;
            end
            write_en = 0;
            for (i = 0; i < 4; i++) begin
                @(posedge clk);
                read_en = 1;
            end
            read_en = 0;
            for (i = 0; i < 4; i++) begin
                @(posedge clk);
                write_en = 1; data_in = i + 40;
            end
            write_en = 0;
            $display("PASS: Pointer wrap-around executed");
        end
    endtask

    task random_stress;
        integer i;
        begin
            $display("\n[TEST] Random Read/Write Stress");
            for (i = 0; i < 20; i++) begin
                @(posedge clk);
                write_en = $random % 2;
                read_en  = $random % 2;
                data_in  = $random % 256;
            end
            write_en = 0; read_en = 0;
            $display("PASS: Random stress done");
        end
    endtask


    initial begin
        clk = 0; reset = 0;
        write_en = 0; read_en = 0; data_in = 0;
        #10;

                if ($value$plusargs("test=%s", testname)) begin
            $display("\n>>> Running Selected Test: %s <<<", testname);
            if (testname == "reset_fifo")              reset_fifo();
            else if (testname == "write_till_full")    write_till_full();
            else if (testname == "write_on_full")      write_on_full();
            else if (testname == "read_till_empty")    read_till_empty();
            else if (testname == "read_on_empty")      read_on_empty();
            else if (testname == "write_read_alternation") write_read_alternation();
            else if (testname == "concurrent_write_read") concurrent_write_read();
            else if (testname == "reset_during_operation") reset_during_operation();
            else if (testname == "pointer_wraparound") pointer_wraparound();
            else if (testname == "random_stress")      random_stress();
            else $display("Invalid test name! No match found for: %s", testname);
        end
        else if ($test$plusargs("alltests")) begin
            $display("\n>>> Running ALL TESTS <<<");
            reset_fifo();
            write_till_full();
            write_on_full();
            read_till_empty();
            read_on_empty();
            write_read_alternation();
            concurrent_write_read();
            reset_during_operation();
            pointer_wraparound();
            random_stress();
        end
        else begin
            $display("\nNo plusargs found. Use one of:");
            $display("   +test=<testname>  (to run single test)");
            $display("   +alltests         (to run all tests)");
        end

        #20;
        $display("\nSimulation completed.\n");
        $finish;
    end
endmodule

