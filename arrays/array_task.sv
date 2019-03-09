// Given a dynamic array in SystemVerilog, how can you resize it to add more elements?
//
//resizing

module dynamic_array_resizing;
  
  bit [7:0]	d_array1[];
  int       d_array2[];

  initial begin
    d_array1 = new[4]; 
    d_array2 = new[3]; 
        
    foreach(d_array1[i])  d_array1[i] = i;

    foreach(d_array2[j])  d_array2[j] = j;

    $display("d_array1 Values ");
    foreach(d_array1[i])  
    $display("\td_aaray1[%0d] = %0d",i, d_array1[i]);

    $display("d_array2 Values are");
    foreach(d_array2[i])   
    $display("\td_aaray2[%0d] = %0d",i, d_array2[i]);
    
    //Increasing the size by overriding the old values 

    d_array1 = new[8]; //size 8

    $display("Size of Array d_array1 %0d",d_array1.size());
    $display("d_array1 Values are ");
    foreach(d_array1[i])   
    $display("\td_aaray1[%0d] = %0d",i, d_array1[i]);

    //Increasing the size by retaining the old values 

    d_array2 = new[5](d_array2); //size 5 , retaining old values 

    $display("Size of Array d_array2 %0d",d_array2.size());
    $display(" d_array2 Values are ");
    foreach(d_array2[i])   
    $display("\td_aaray2[%0d] = %0d",i, d_array2[i]);
    
  end
endmodule
 


//Given a queue with potential duplicate values, write code to remove all duplicate elements.

module unique_queue_example;
  int q[$] = '{10, 20, 30, 20, 10, 40, 30};

  initial begin
    $display("Original queue: %p", q);

    q = unique q; // remove all duplicate elements

    $display("after removing duplicates: %p", q);
  end
endmodule

module remove_duplicates_from_queue;
  int q[$] = '{1, 2, 2, 3, 4, 4, 5, 1};
  int unique_q[$];

  initial begin
    $display("Original Queue : %p", q);

    // Iterate through each element of the queue
    foreach (q[i]) begin
      // Add element only if it's not already present in unique_q
      if (!(q[i] inside {unique_q}))
        unique_q.push_back(q[i]);
    end

    $display("Queue after removing duplicates: %p", unique_q);
  end
endmodule


//Write code to reverse the elements in a queue.

module reverse_queue_builtin;
  int q[$] = {1, 2, 3, 4, 5};

  initial begin
    $display("Original queue: %p", q);

    // Reverse the queue in-place using built-in method
    q.reverse();

    $display("Reversed queue: %p", q);
  end
endmodule


//Given a static or dynamic array, how would you find the maximum value?

module max_static_array;
  int arr[5] = '{10, 25, 7, 30, 15};
  int max_val;

  initial begin
    max_val = arr[0]; // Initialize with first element

    // Loop through the array to find max
    for (int i = 1; i < $size(arr); i++) begin
      if (arr[i] > max_val)
        max_val = arr[i];
    end

    $display("Maximum value in static array: %0d", max_val);
  end
endmodule

module max_array_builtin;
  int arr[$] = {12, 45, 8, 33, 21};

  initial begin
    int max_val = arr.max(); // Built-in method for dynamic arrays
    $display("Maximum value (built-in): %0d", max_val);
  end
endmodule


//Describe how you would use a queue to implement a FIFO (First-In-First-Out) buffer.
//Write code to concatenate two dynamic arrays.

module concat_dynamic_arrays_one_liner;
  int arr1[$] = {1, 2, 3};
  int arr2[$] = {4, 5, 6};
  int arr_concat[$]; // New array for concatenation

  initial begin
    $display("Array 1: %p", arr1);
    $display("Array 2: %p", arr2);

    // Concatenate in one line
    arr_concat = {arr1, arr2};

    $display("Concatenated Array (one-liner): %p", arr_concat);
  end
endmodule

//Implement a stack (Last-In-First-Out behavior) using a queue.
//Given an array of integers, copy only the even numbers into a new array.
module copy_even_numbers_compact;
  int arr[$] = {1, 2, 3, 4, 5, 6};
  int even_arr[$];

  initial begin
    $display("Original array: %p", arr);

    // One-liner using foreach + conditional push
    foreach (arr[i]) if (arr[i] % 2 == 0) 
    even_arr.push_back(arr[i]);

    $display("Even numbers array (compact): %p", even_arr);
  end
endmodule

//Write a code snippet to remove all elements from a dynamic array that are less than a specified threshold.

module remove_below_threshold_foreach;
  int arr[$] = {7, 15, 2, 18, 9};
  int threshold = 10;

  initial begin
    $display("Original array: %p", arr);

    // Iterate backwards using foreach
    foreach (arr[i]) begin
      if (arr[i] < threshold)
        arr.delete(i);
    end

    $display("Array after removing elements < %0d: %p", threshold, arr);
  end
endmodule

// Count the number of times each unique element appears in a dynamic array.
module count_unique_elements_foreach;
  int arr[$] = {2, 5, 2, 3, 5, 2, 3, 7};
  int count[$]; // Associative array to store counts

  initial begin
    $display("Original array: %p", arr);

    // Count occurrences using foreach
    foreach (arr[i]) begin
      count[arr[i]]++;  // Increment count for each element
    end

    // Display results using foreach over associative array
    foreach (count[key]) begin
      $display("Element %0d appears %0d time(s)", key, count[key]);
    end
  end
endmodule

// Implement a function to shuffle the elements of a queue randomly.

module arr_ordering_ex;
  int arr[8] = '{5, 6, 9, 2, 3, 4, 6, 10};
  int que[$] = {5, 6, 9, 2, 3, 4, 6, 10};

  // Function to shuffle a queue (works for dynamic arrays too)
  function void shuffle_method(ref int q[$]);
    q.shuffle(); // Built-in shuffle for queue/dynamic array
  endfunction

  initial begin
    $display("Original queue: %p", que);
    shuffle_method(que);
    $display("Shuffled queue: %p", que);

    // If you want to shuffle arr, first copy to a queue
    int arr_queue[$] = arr;
    $display("Original arr copy as queue: %p", arr_queue);
    shuffle_method(arr_queue);
    $display("Shuffled arr copy as queue: %p", arr_queue);
  end
endmodule


module shuffle_queue_builtin;
  int q[$] = {1, 2, 3, 4, 5, 6};

  initial begin
    $display("Original queue: %p", q);

    q.shuffle(); // Built-in shuffle

    $display("Shuffled queue: %p", q);
  end
endmodule

module queue_manipulation;
  int queue_1[$]; // Declare a queue of integers

  initial begin
    // Push elements into the queue
    queue_1.push_back(8);
    queue_1.push_back(2);
    queue_1.push_back(6);
    queue_1.push_back(1);

    // Display before shuffle
    $display("\n-======= shuffle =======-");
    $display("Before:\t %p", queue_1);

    // Built-in shuffle method — randomizes element order
    queue_1.shuffle();

    // Display after shuffle
    $display("After :\t %p", queue_1);
    $display("-=======================-");
  end
endmodule


// Write a function that returns the smallest *n* elements from a dynamic array.


// Given two sorted dynamic arrays, write a function to merge them into a single sorted array

module merge_sorted_func_unique;
  int arr1[$] = '{1, 4, 6, 8};
  int arr2[$] = '{2, 4, 5, 6, 9};
  int merged_unique[$];

  // Function to merge two arrays, sort, and remove duplicates using unique()
  function int[$] merge_sort_unique(input int a[$], input int b[$]);
    int temp[$];

    // Step 1: Combine arrays
    temp = a;
    foreach (b[i]) temp.push_back(b[i]);

    // Step 2: Sort
    temp.sort();

    // Step 3: Remove duplicates using unique()
    temp.unique();  // removes duplicate elements in-place

    return temp; // return the sorted unique array
  endfunction

  initial begin
    $display("Array 1: %p", arr1);
    $display("Array 2: %p", arr2);

    merged_unique = merge_sort_unique(arr1, arr2);

    $display("Merged Unique Sorted Array: %p", merged_unique);
  end
endmodule

