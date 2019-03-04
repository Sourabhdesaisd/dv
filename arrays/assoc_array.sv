
module associative_array_int;
  bit [7:0] data[int]; 

  initial begin
    data[10] = 8'hAA;
    data[20] = 8'hBB;
    //data[30] = 8'h12;
    data[40] = 8'hCC;

    foreach (data[i])
      $display("Index = %0d, Data = %0h", i, data[i]);

    // Check specific 
    if (data.exists(30))
      $display("Key 30 exists");
    else
      $display("Key 30 does not exist");
  end
endmodule

module associative_array;

  int student_marks[string];
  string name;

  initial begin
    student_marks["Alice"] = 85;
    student_marks["Bob"]   = 90;
    student_marks["Carol"] = 78;

    $display("Marks of Alice = %0d", student_marks["Alice"]);
    $display("Marks of Bob   = %0d", student_marks["Bob"]);
    $display("Marks of Carol = %0d", student_marks["Carol"]);

    if (student_marks.exists("Dave"))
      $display("Dave's marks = %0d", student_marks["Dave"]);
    else
      $display("Dave not found");

        foreach (student_marks[name])
      $display("Student: %s, Marks: %0d", name, student_marks[name]);

    // Delete one 
    student_marks.delete("Bob");

    $display("--- After deleting Bob ---");
    foreach (student_marks[name])
      $display("Student: %s, Marks: %0d", name, student_marks[name]);
  end

endmodule

module associative_array_example;
   bit [7:0] array [int];
   int index;
  
  initial begin
    
    array[5] = 2;
    array[10] = 4;
    array[7] = 6;
    array[9] = 8;
    array[20] = 10;
    array[13] = 12;
    
    foreach (array[i]) $display("array[%0d] = %0d", i, array[i]);
    
    $display("size = %0d, Number of entries = %0d of array", array.size(), array.num());
    
    // exists method
    if(array.exists(7))
      $display("An element exists at index = 7");
    else
      $display("An element doesn't exists at index = 7");
    
    if(array.exists(8))
      $display("An element exists at index = 8");
    else 
      $display("An element doesn't exists at index = 8");
    
    // first, last, prev, next method
    array.first(index);
    $display("First index of array = %0d", index);
    
    array.last(index);
    $display("Last index of array = %0d", index);
    
    index = 9;
    array.prev(index);  // Previous index of 9
    $display("Prev index of 9 is %0d", index);
    
    index = 10;
    array.next(index); // Next index of 10
    $display("Next index of 10 is %0d", index);
    
    // Delete particular index
    array.delete(7);
    
    // Print array elements
    $display("After deleting element having index 7");
    foreach (array[i]) $display("array[%0d] = %0d", i, array[i]);
    
    // Delete complete array
    array.delete();
    $display("size = %0d of array", array.size());
  end
endmodule



module associative_array3;
  int a_array1[bit [7:0]]; //index type is bit [7:0] and entry type is int
  bit a_array2[string]   ; //index type is string and entry type is bit
  
  initial begin
    a_array1[5] = 10;
    a_array1[8] = 20;
        
    a_array2["Sourabh"] = 1;
    a_array2["Desai"]  = 0;
       
    foreach(a_array1[index]) 
      $display("a_array1[%0d] = %0d",index,a_array1[index]);
    foreach(a_array2[index]) 
      $display("a_array2[%0s] = %0d",index,a_array2[index]);
  end
endmodule

module associative_array4;
  int a_array[*];  
  int index;
  
  initial begin
    repeat(3) begin
      a_array[index] = index*2;
      index=index+4;
    end
    
    $display("[Before-Delete] Associative array size is %0d",a_array.size());
    a_array.delete();
    $display("[After -Delete] Associative array size is %0d",a_array.size());    
    
  end
endmodule



module associative_array2;
  int a_array[*];  
  int index;
  
  initial begin
    repeat(3) begin
      a_array[index] = index*2;
      index=index+4;
    end
    
    //exists()
    if(a_array.exists(8))
      $display("Index 8 exists in a_array");
    else 
      $display("Index 8 doesnt exists in a_array");
    
    //last()
    a_array.last(index);
    $display("Last entry is a_array[%0d] = %0d",index,a_array[index]);
    
    //prev()
    a_array.prev(index);
    $display("prev entry is a_array[%0d] = %0d",index,a_array[index]);
    
    //next()
    a_array.next(index);
    $display("next entry is a_array[%0d] = %0d",index,a_array[index]);
  end
endmodule

/*

module associative_array1;
  int a_array[*];  
  int index;
  
  initial begin
  
    repeat(3) begin
      a_array[index] = index*2;
      index=index+4;
    end

    //num() 
    $display("\tNumber of entries in a_array is %0d",a_array.num());
    $display("--- Associative array a_array entries and Values are ---");
    foreach(a_array[i])
    $display("\ta_array[%0d] \t = %0d",i,a_array[i]);
    
    //first()
    array.first(index);
    $display("First index of array = %0d", index);
    //last
    array.last(index);
    $display("Last index of array = %0d", index);
    end
endmodule
*/
