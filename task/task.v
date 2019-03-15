  // Static task (default type)

module static_task; 
  int x;

  task sum(input int a, b, output int c);
    int temp = 0;         // static by default
    temp = temp + 1;      // shared across calls
    c = a + b + temp;     // adds an extra
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

  // Automatic task - new memory each time

module sv_automatic_task;
  int x;

  task automatic sum(input int a, b, output int c);
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

  // Task with a static variable inside

module sv_static_variable;
  int result;

  task add_value(input int a, output int b);
    static int total = 0;  // remembers previous value
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

  // Pass by VALUE (default)

module pass_by_value;
  int a = 10, b = 5, result;

  task add(input int x, y, output int sum);
    x = x + 10;        // changes local copy only
    sum = x + y;
    $display("Inside Task: x=%0d, y=%0d, sum=%0d", x, y, sum);
  endtask

  initial begin
    add(a, b, result);
    $display("Outside Task: a=%0d, b=%0d, result=%0d", a, b, result);
  end
endmodule

  // Pass by REFERENCE

module pass_by_ref;
  int a = 10, b = 5, result;

  task add(ref int x, y, output int sum);
    x = x + 10;        // changes original 'a'
    sum = x + y;
    $display("Inside Task: x=%0d, y=%0d, sum=%0d", x, y, sum);
  endtask

  initial begin
    add(a, b, result);
    $display("Outside Task: a=%0d, b=%0d, result=%0d", a, b, result);
  end
endmodule

  // Pass by CONST REF (read-only)

module pass_by_const_ref;
  int a = 10, b = 5, result;

  task add(const ref int x, const ref int y, output int sum);
    // x = x + 10;   // ? Not allowed: const ref cannot be modified
    sum = x + y;
    $display("Inside Task: x=%0d, y=%0d, sum=%0d", x, y, sum);
  endtask

  initial begin
    add(a, b, result);
    $display("Outside Task: a=%0d, b=%0d, result=%0d", a, b, result);
  end
endmodule

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

/*
ncvlog: *W,DLCPTH (/tools/cadence/FOUNDRY/cds.lib,19): cds.lib Invalid path '/home/install/FOUNDRY/rfLib_new' (cds.lib command ignored).
file: task.v
    int temp = 0;         // static by default
             |
ncvlog: *W,VARIST (task.v,7|13): Local static variable with initializer requires 'static' keyword.
	module worklib.static_task:v
		errors: 0, warnings: 1
	module worklib.sv_automatic_task:v
		errors: 0, warnings: 0
	module worklib.sv_static_variable:v
		errors: 0, warnings: 0
	module worklib.pass_by_value:v
		errors: 0, warnings: 0
  task add(ref int x, y, output int sum);
                   |
ncvlog: *E,REFANA (task.v,87|19): reference argument is illegal inside static task-function declaration.
  task add(ref int x, y, output int sum);
                      |
ncvlog: *E,REFANA (task.v,87|22): reference argument is illegal inside static task-function declaration.
	module worklib.pass_by_ref:v
		errors: 2, warnings: 0
  task add(const ref int x, const ref int y, output int sum);
                         |
ncvlog: *E,REFANA (task.v,104|25): reference argument is illegal inside static task-function declaration.
  task add(const ref int x, const ref int y, output int sum);
                                          |
ncvlog: *E,REFANA (task.v,104|42): reference argument is illegal inside static task-function declaration.
	module worklib.pass_by_const_ref:v
		errors: 2, warnings: 0
	module worklib.blocking_task_demo:v
		errors: 0, warnings: 0
	module worklib.nonblocking_task_demo:v
		errors: 0, warnings: 0
	Total errors/warnings found outside modules and primitives:
		errors: 0, warnings: 2
irun: *E,VLGERR: An error occurred during parsing.  Review the log file for errors with the code *E and fix those identified problems to proceed.  Exiting with code (status 1).
[vv2trainee8@compute-srv2 task]$ 
*/
