class sv_class;
  //class proporties
  int x;
  
  //method-1
  task set(int i);
    x = i;
  endtask
  
  //method-2
  function int get();
    return x;
  endfunction
  
endclass
  
module sv_class_ex;
 sv_class class_1;
  
  initial begin
    sv_class class_2 = new();
    class_1 = new();
    
    class_1.set(10);
    class_2.set(20);
    
    $display("\tclass_1 :: Value of x = %0d",class_1.get());
    $display("\tclass_2 :: Value of x = %0d",class_2.get());
  end
endmodule


class packet;
  
  //class properties
  bit [31:0] addr;
  bit [31:0] data;
  bit		 write;
  string	 pkt_type;
  
  //constructor
  function new(bit [31:0] addr,data,bit write,string pkt_type);
    addr  = addr;
    data  = data;
    write = write;
    pkt_type = pkt_type;
  endfunction
  
  //method to display class prperties
  function void display();
    $display("\t addr  = %0h",addr);
    $display("\t data  = %0h",data);
    $display("\t write = %0h",write);
    $display("\t pkt_type  = %0s",pkt_type);
  endfunction
  
endclass

module sv_constructor;
  packet pkt;

  initial begin
    pkt = new(32'h10,32'hFF,1,"GOOD_PKT");
    pkt.display();
  end
  
endmodule


class packet;
  
  //class properties
  bit [31:0] addr;
  bit [31:0] data;
  bit		 write;
  string	 pkt_type;
  
  //constructor
  function new(bit [31:0] addr,data,bit write,string pkt_type);
    this.addr  = addr;
    this.data  = data;
    this.write = write;
    this.pkt_type = pkt_type;
  endfunction
  
  //method to display class prperties
  function void display();
    $display("\t addr  = %0h",addr);
    $display("\t data  = %0h",data);
    $display("\t write = %0h",write);
    $display("\t pkt_type  = %0s",pkt_type);
  endfunction
  
endclass

module sv_constructor;
  packet pkt;

  initial begin
    pkt = new(32'h10,32'hFF,1,"GOOD_PKT");
    pkt.display();
  end
  
endmodule


class packet;
  
  //class properties
  bit [31:0] addr;
  bit [31:0] data;
  bit		 write;
  string	 pkt_type;
  
  //constructor
  function new();
    addr  = 32'h10;
    data  = 32'hFF;
    write = 1;
    pkt_type = "GOOD_PKT";
  endfunction
  
  //method to display class prperties
  function void display();
    $display("\t addr  = %0d",addr);
    $display("\t data  = %0h",data);
    $display("\t write = %0d",write);
    $display("\t pkt_type  = %0s",pkt_type);
  endfunction
  
endclass

module sv_constructor;
  packet pkt;

  initial begin
    pkt = new();
    pkt.display();
  end  
endmodule


//in the below example,
//The class has the variable packet_id, which is the unique ID assigned to the packet;
//Static variable no_of_pkts_created, no_of_pkts_created will get incremented on every object creation.no_of_pkts_created is assigned to packet_id.

class packet;
  
  //class properties
  byte packet_id;
    
  //static property to keep track of number of pkt's created
   static byte no_of_pkts_created;
  
  //constructor
  function new();
    //incrementing pkt count on creating an object
    no_of_pkts_created ++ ;
    packet_id = no_of_pkts_created;
  endfunction
  
  //method to display class prperties
  function void display();
    $display("\t packet_id  = %0d",packet_id);
  endfunction 
endclass

module static_properties;
  packet pkt[3];

  initial begin
    foreach(pkt[i]) begin
      pkt[i] = new();
      pkt[i].display();
    end
  end  
endmodule


class packet;
    
  //static property to keep track of number of pkt's created
  static byte no_of_pkts_created;
  
  //constructor
  function new();
    //incrementing pkt count on creating an object
    no_of_pkts_created++;
  endfunction
    
  //Static method to display class prperties
  static function void display_packets_created();
    $display("\t %0d packets created.",no_of_pkts_created);
  endfunction 
endclass

module static_properties;
  packet pkt[3];

  initial begin
    foreach(pkt[i]) begin
      pkt[i] = new();
    end
    pkt[0].display_packets_created();
  end  
endmodule



//Static method trying to access a non-static variable
//
class packet;
  byte packet_id;
  
  //static property to keep track of number of pkt's created
  static byte no_of_pkts_created;
  
  //constructor
  function new();
    //incrementing pkt count on creating an object
    no_of_pkts_created++;
  endfunction
    
  //Static method to display class prperties
  static function void display_packets_created();
    $display("\t Packet Id is %0d",packet_id);
    $display("\t %0d packets created.",no_of_pkts_created);
  endfunction 
endclass

module static_properties;
  packet pkt[3];

  initial begin
    foreach(pkt[i]) begin
      pkt[i] = new();
    end
    pkt[0].display_packets_created();
  end  
endmodule

//Accessing static class properties without creating an object

class packet;
    
  //static property to keep track of number of pkt's created
  static byte no_of_pkts_created;
  
  //constructor
  function new();
    //incrementing pkt count on creating an object
    no_of_pkts_created++;
  endfunction
    
  //Static method to display class prperties
  static function void display_packets_created();
    $display("\t %0d packets created.",no_of_pkts_created);
  endfunction 
endclass
?
module static_properties;
  packet pkt[3];
  packet p;
?
  initial begin
    foreach(pkt[i]) begin
      pkt[i] = new();
    end
    
    //Accesing static Variable with class handle p
    $display("\t %0d packets created.",p.no_of_pkts_created);
    
    //Accesing static Method with class handle p
    p.display_packets_created();
  end  
endmodule

//Class assignment example

class packet;
  
  //class properties
  bit [31:0] addr;
  bit [31:0] data;
  bit		 write;
  string	 pkt_type;
  
  //constructor
  function new();
    addr  = 32'h10;
    data  = 32'hFF;
    write = 1;
    pkt_type = "GOOD_PKT";
  endfunction
  
  //method to display class prperties
  function void display();
    $display("\t addr  = %0d",addr);
    $display("\t data  = %0h",data);
    $display("\t write = %0d",write);
    $display("\t pkt_type  = %0s",pkt_type);
  endfunction
  
endclass

module class_assignment;
  packet pkt_1;
  packet pkt_2;

  initial begin
    pkt_1 = new();
    $display("\t****  calling pkt_1 display  ****"); 
    pkt_1.display();
    //assigning pkt_1 to pkt_2
    pkt_2 = pkt_1;
    $display("\t****  calling pkt_2 display  ****");
    pkt_2.display();
    //changing values with pkt_2 handle
    pkt_2.addr = 32'hAB;
    pkt_2.pkt_type = "BAD_PKT";
    //changes made with pkt_2 handle will reflect on pkt_1
    $display("\t****  calling pkt_1 display  ****");
    pkt_1.display();
  end
  
endmodule


//Shallow Copy
//
class address_range;
  bit [31:0] start_address;
  bit [31:0] end_address  ;
  
  function new();
    start_address = 10;
    end_address   = 50;
  endfunction
endclass

//-- class ---    
class packet;
  
  //class properties
  bit [31:0] addr;
  bit [31:0] data;
  address_range ar; //class handle
  
  //constructor
  function new();
    addr  = 32'h10;
    data  = 32'hFF;
    ar = new(); //creating object
  endfunction
  
  //method to display class prperties
  function void display();
    $display("\t addr  = %0h",addr);
    $display("\t data  = %0h",data);
    $display("\t start_address  = %0d",ar.start_address);
    $display("\t end_address  = %0d",ar.end_address);
  endfunction
  
endclass

// -- module ---
module class_assignment;
  packet pkt_1;
  packet pkt_2;

  initial begin
    
    pkt_1 = new();   //creating pkt_1 object
    $display("\t****  calling pkt_1 display  ****");
    pkt_1.display();
    
    pkt_2 = new pkt_1;   //creating pkt_2 object and copying pkt_1 to pkt_2
    $display("\t****  calling pkt_2 display  ****");
    pkt_2.display();
    
    //changing values with pkt_2 handle
    pkt_2.addr = 32'h68;
    pkt_2.ar.start_address = 60;
    pkt_2.ar.end_address = 80;
    $display("\t****  calling pkt_1 display after changing pkt_2 properties ****");
    //changes made to pkt_2.ar properties reflected on pkt_1.ar, so only handle of the object get copied, this is called shallow copy 
    pkt_1.display();
    $display("\t****  calling pkt_2 display after changing pkt_2 properties ****");
    pkt_2.display(); //
  end
  
endmodule
