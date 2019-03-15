module fork_join_example;
  initial begin
    $display("\n--- fork ... join (wait for all) --- at %0t", $time);
    fork
      #10 $display("T1 finished at %0t", $time);
      #5  $display("T2 finished at %0t", $time);
      #7  $display("T3 finished at %0t", $time);
    join
    $display("After join: all threads done at %0t\n", $time);
    #1 $finish;
  end
endmodule


module fork_join_any_example;
  initial begin
    $display("\n--- fork ... join_any (first wins) --- at %0t", $time);
    fork
      #20 $display("Slow finished at %0t", $time);
      #8  $display("Fast finished at %0t", $time);
      #15 $display("Medium finished at %0t", $time);
    join_any
    $display("After join_any: at least one finished at %0t", $time);
    // Note: remaining threads continue to run unless disabled
    #25 $finish;
  end
endmodule


module fork_join_none_example;
  initial begin
    $display("\n--- fork ... join_none (background) --- at %0t", $time);
    fork
      #3  $display("BG1 at %0t", $time);
      #6  $display("BG2 at %0t", $time);
      #9  $display("BG3 at %0t", $time);
    join_none
    $display("Main thread continues immediately at %0t", $time);
    // If we didn't wait, simulation might finish before backgrounds run
    #12 $display("After wait allowing BG finish at %0t\n", $time);
    #1 $finish;
  end
endmodule

