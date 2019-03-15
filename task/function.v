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

  function void change_ref(ref int a);
    a = a + 10;   // changes the original variable
    $display("Inside function: a = %0d", a);
  endfunction

  int x = 5;

  initial begin
    change_ref(x);
    $display("Outside function: x = %0d", x);
  end

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



/*
ncvlog: *W,DLCPTH (/tools/cadence/FOUNDRY/cds.lib,19): cds.lib Invalid path '/home/install/FOUNDRY/rfLib_new' (cds.lib command ignored).
file: function.v
	module worklib.func_example:v
		errors: 0, warnings: 0
	module worklib.func_void_example:v
		errors: 0, warnings: 0
	module worklib.func_compare:v
		errors: 0, warnings: 0
	module worklib.pass_by_value:v
		errors: 0, warnings: 0
  function void change_ref(ref int a);
                                   |
ncvlog: *E,REFANA (function.v,73|35): reference argument is illegal inside static task-function declaration.
	module worklib.pass_by_reference:v
		errors: 1, warnings: 0
	module worklib.pass_by_name:v
		errors: 0, warnings: 0
	module worklib.pass_by_position:v
		errors: 0, warnings: 0
	Total errors/warnings found outside modules and primitives:
		errors: 0, warnings: 2
irun: *E,VLGERR: An error occurred during parsing.  Review the log file for errors with the code *E and fix those identified problems to proceed.  Exiting with code (status 1).
[vv2trainee8@compute-srv2 task]$ 
*/

