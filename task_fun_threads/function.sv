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
  function void Desai(input string name);
    $display("Hello, %s!", name);
  endfunction

  initial begin
    Desai("Sourabh");
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


/*module pass_by_reference;
  int x,y,z;

  //function to add two integer numbers.
  function  int sum(ref int x,y);
    x = x+y;
    return x+y;   
  endfunction

  initial begin
    x = 20;
    y = 30;
    z = sum(x,y);
    $display("\tValue of x = %0d",x);
    $display("\tValue of y = %0d",y);
    $display("\tValue of z = %0d",z);
  end
endmodule*/


module pass_by_reference1;
  int x,y,z;

  //function to add two integer numbers.
  function automatic int sum(ref int x,y);
    x = x+y;
    return x+y;   
  endfunction

  initial begin
    x = 20;
    y = 30;
    z = sum(x,y);
    $display("\tValue of x = %0d",x);
    $display("\tValue of y = %0d",y);
    $display("\tValue of z = %0d",z);
  end
endmodule

module pass_by_reference2;

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
    // Pass by position 
    result = compute(5, 3, 2);   // a=5, b=3, c=2
    $display("Result = %0d", result);
  end

endmodule

