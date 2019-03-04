module fixedsize_array;
  int array1[6];               //single dimension array
  int array2[5:0];             //single dimension array
  int array3[2:0][3:0];        //multi dimension array
  int array4[4:0];
 
  initial begin
    //array initialization
    array1 = '{0,1,2,3,4,5};
    array2 = '{0,1,2,3,4,5};
    array3 = '{'{0,1,2,3},'{4,5,6,7},'{8,9,10,11}};
 
    $display("displaying array1");
    foreach(array1[i])
    $display("\t array1[%0d] = %0d",i,array1[i]);
 
    $display("displaying array2");
    for(int i=0;i<6;i++) 
      $display("\t array2[%0d] = %0d",i,array2[i]);
 
    $display("displaying array3");
    foreach(array3[i,j])
    $display("\t array3[%0d][%0d] = %0d",i,j,array3[i][j]);
 
    $display("displaying uninitialized array4");
    for(int i=0;i<5;i++)
    $display("\t array4[%0d] = %0d",i,array4[i]);
  end
endmodule


module tb;
	bit [7:0] 	m_data; 	// 1D packed array
	
	initial begin
		m_data = 8'h12; 
		$display("displaying 1D");
		for (int i = 0; i < $size(m_data); i++) begin
			$display ("m_data[%0d] = %b", i, m_data[i]);
		end
	end
endmodule


module tb2;
  bit [3:0][7:0] 	m_data2; 	// MDA	
	initial begin
		m_data2 = 32'h1234_5678;
		$display("displaying MDA 2D");
      for (int i = 0; i < $size(m_data2); i++) begin
        $display ("m_data2[%0d] = %b (0x%0h)", i, m_data2[i], m_data2[i]);
		end
	end
endmodule

module tb3;
  int array[2:0][2:0][2:0] = '{'{'{1, 10, 100}, '{2, 20, 200}, '{3, 30, 300}},
                         '{'{4, 40, 400}, '{5, 50, 500}, '{6, 60, 600}},
                         '{'{7, 70, 700}, '{8, 80, 800}, '{9, 90, 900}}
                        };
  initial begin
		$display("displaying MDA 3D");
  
    foreach (array[i,j, k]) begin
      $display("array[%0d][%0d][%0d] = %0d", i,j, k, array[i][j][k]);
    end
  end
endmodule

// packed
module array_packed;
  bit [2:0][3:0] array = '{4'h2, 4'h4, 4'h6};
  initial begin
		$display("displaying Packed array");
 
    foreach (array[i]) begin
      $display("array[%0h] = %0h", i, array[i]);
    end
  end
endmodule

//unpacked

module array_example;
  int array [2:0][3:0] = '{'{1, 2, 3, 4},
                           '{5, 6, 7, 8},
                           '{9, 10, 11, 12}
                          };
  initial begin
  $display("displaying Unpacked array");
    foreach (array[i,j]) begin
      $display("array[%0d][%0d] = %0d", i, j, array[i][j]);
    end
  end
endmodule

// packed + unpacked mix

module array_mixed;
  bit [4:0] array[2:0][1:0] = '{'{5'h5, 5'h1},
                                '{5'h10, 5'h2},
                                '{5'h15, 5'h3}
                               };
  initial begin
  $display("displaying packed Unpacked mixed array");
  
    foreach (array[i,j]) begin
      $display("array[%0h][%0h] = %0h", i, j, array[i][j]);
    end
  end
endmodule

