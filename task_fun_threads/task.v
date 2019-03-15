// 1) Static task (local static variable with initializer requires 'static')
module static_task;
  int x;

  task sum(input int a, input int b, output int c);
    static int temp = 0;         // explicit static required by some simulators
    temp = temp + 1;            // shared across calls
    c = a + b + temp;           // adds an extra
  endtask

  initial begin
    int y;
    sum(10, 5, y);
    $display("Call 1: Value of y = %0d", y);
    sum(20, 5, y);
    $display("Call 2: Value of y = %0d", y);
    sum(30, 5, y);
    $display("Call 3: Value of y = %0d", y);
  end
endmodule


// 2) Automatic task - new memory each time
module sv_automatic_task;
  int x;

  task automatic sum(input int a, input int b, output int c);
    int temp = 0;          // fresh copy for each call
    temp = temp + 1;
    c = a + b + temp;
  endtask

  initial begin
    sum(10, 5, x);
    $display("Call 1: Value of x = %0d", x);
    sum(20, 5, x);
    $display("Call 2: Value of x = %0d", x);
    sum(30, 5, x);
    $display("Call 3: Value of x = %0d", x);
  end
endmodule


// 3) Task with a static variable inside
module sv_static_variable;
  int result;

  task add_value(input int a, output int b);
    static int total = 0;  // remembers previous value across calls
    total = total + a;
    b = total;
  endtask

  initial begin
    add_value(10, result);
    $display("After Call 1: total = %0d", result);
    add_value(5, result);
    $display("After Call 2: total = %0d", result);
    add_value(7, result);
    $display("After Call 3: total = %0d", result);
  end
endmodule


// 4) Pass by VALUE (default)
module pass_by_value;
  int a = 10, b = 5, result;

  task add(input int x, input int y, output int sum);
    x = x + 10;        // changes local copy only
    sum = x + y;
    $display("Inside Task: x=%0d, y=%0d, sum=%0d", x, y, sum);
  endtask

  initial begin
    add(a, b, result);
    $display("Outside Task: a=%0d, b=%0d, result=%0d", a, b, result);
  end
endmodule


// 5) Pass by REFERENCE (task must be automatic to allow ref arguments)
module pass_by_ref;
  int a = 10, b = 5, result;

  task automatic add(ref int x, input int y, output int sum);
    x = x + 10;        // changes original 'a'
    sum = x + y;
    $display("Inside Task: x=%0d, y=%0d, sum=%0d", x, y, sum);
  endtask

  initial begin
    add(a, b, result);
    $display("Outside Task: a=%0d, b=%0d, result=%0d", a, b, result);
  end
endmodule


// 6) Pass by CONST REF (read-only) - also automatic
module pass_by_const_ref;
  int a = 10, b = 5, result;

  task automatic add(const ref int x, const ref int y, output int sum);
    // x = x + 10;   // Not allowed: const ref cannot be modified
    sum = x + y;
    $display("Inside Task: x=%0d, y=%0d, sum=%0d", x, y, sum);
  endtask

  initial begin
    add(a, b, result);
    $display("Outside Task: a=%0d, b=%0d, result=%0d", a, b, result);
  end
endmodule


// 7) Blocking task demo (blocking call - caller waits)
module blocking_task_demo;

  task display_msg(input string msg);
    #5; // wait for 5 time units
    $display("[%0t] Task says: %s", $time, msg);
  endtask

  initial begin
    $display("[%0t] Start", $time);
    display_msg("Blocking Call");
    $display("[%0t] After Task", $time);
  end

endmodule


// 8) Non-blocking task demo (use fork/join_none)
module nonblocking_task_demo;

  task display_msg(input string msg);
    #5;
    $display("[%0t] Task says: %s", $time, msg);
  endtask

  initial begin
    $display("[%0t] Start", $time);
    fork
      display_msg("Non-blocking Call");
    join_none // continue without waiting
    $display("[%0t] After fork", $time);
    #10; // let the task complete
  end

endmodule

