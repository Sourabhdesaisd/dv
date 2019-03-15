// Combined and updated SystemVerilog file
// Fix: 'ref' argument moved to a task (automatic) to avoid simulator errors

module func_example;

  // Function to add two integers
  function int add(input int a, b);
    add = a + b;   // return statement (same as return add;)
  endfunction

  int result;

  initial begin
    result = add(10, 20);
    $display("Sum = %0d", result);
  end

endmodule


module func_void_example;

  // Function that prints a message, returns nothing
  function void greet(input string name);
    $display("Hello, %s!", name);
  endfunction

  initial begin
    greet("Sourabh");
  end

endmodule


module func_compare;

  // Normal function that returns value
  function int add(input int a, b);
    return a + b;             // must return something
  endfunction

  // Void function that just prints
  function void show_sum(input int a, b);
    $display("Sum = %0d", a + b);  // no return
  endfunction

  int result;

  initial begin
    result = add(10, 5);       // store return value
    $display("Returned Sum = %0d", result);

    show_sum(10, 5);           // just prints inside
  end

endmodule


module pass_by_value;

  function void change_value(input int a);
    a = a + 10;   // modifies only the local copy
    $display("Inside function: a = %0d", a);
  endfunction

  int x = 5;

  initial begin
    change_value(x);
    $display("Outside function: x = %0d", x);
  end

endmodule


module pass_by_reference;

  // Converted to a task because 'ref' arguments are illegal in static functions
  task automatic change_ref(ref int a);
    a = a + 10;   // changes the original variable
    $display("Inside task: a = %0d", a);
  endtask

  int x = 5;

  initial begin
    change_ref(x);
    $display("Outside task: x = %0d", x);
  end

  // Optional: If your simulator supports automatic functions with ref,
  // you can use the following (tool-dependent):
  // function automatic void change_ref_func(ref int a);
  //   a = a + 10;
  //   $display("Inside function: a = %0d", a);
  // endfunction

endmodule


module pass_by_name;

  function int compute(input int a, input int b, input int c);
    return (a + b) * c;
  endfunction

  int result;

  initial begin
    // Pass by name (order can change)
    result = compute(.c(2), .a(5), .b(3));
    $display("Result = %0d", result);
  end

endmodule


module pass_by_position;

  function int compute(input int a, input int b, input int c);
    return (a + b) * c;
  endfunction

  int result;

  initial begin
    // Pass by position (order matters)
    result = compute(5, 3, 2);   // a=5, b=3, c=2
    $display("Result = %0d", result);
  end

endmodule

