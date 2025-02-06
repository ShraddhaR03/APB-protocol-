class apb_seq extends uvm_sequence #(seq_item);
  `uvm_object_utils(apb_seq)
  seq_item h_pkt;
  
  
  
  virtual apb_intf vif;
  function new(string name = "apb_seq");
    super.new(name);
    
    `uvm_info("seq", "Inside apb_seq new", UVM_MEDIUM)
  endfunction
  
  virtual task body();
   
    write(); 
    //#30;
    read();
        
  endtask
  
 
  task write(); 
    `uvm_info("apb_seq", "Inside write task", UVM_MEDIUM)
    h_pkt = seq_item::type_id::create("h_pkt");
   
    start_item(h_pkt);  
    h_pkt.paddr = 7;
    h_pkt.pwdata = 49;
    h_pkt.pwrite =1;
    finish_item(h_pkt);
    `uvm_info("apb_seq", "Finished write item h_pkt", UVM_MEDIUM) 
  endtask
  
 
  task read(); 
    `uvm_info("apb_seq", "Inside read_no_wait task", UVM_MEDIUM)

    h_pkt = seq_item::type_id::create("h_pkt");
    if (h_pkt == null) begin
      `uvm_error("apb_seq", "Failed to create h_pkt")
    end else begin
      `uvm_info("apb_seq", "Successfully created h_pkt", UVM_MEDIUM)
    end
    
    start_item(h_pkt);
    h_pkt.paddr = 7;
    h_pkt.pwrite=0;
    //h_pkt.prdata = 1;
    
    finish_item(h_pkt);
    `uvm_info("apb_seq", "Finished read_no_wait item h_pkt", UVM_MEDIUM)
  endtask
  
endclass
    
    // int a=1;
//     `uvm_info("apb_seq", "Inside multiple write task", UVM_MEDIUM)

//     h_pkt = seq_item::type_id::create("h_pkt");
//     if (h_pkt == null) begin
//       `uvm_error("apb_seq", "Failed to create h_pkt")
//     end else begin
//       `uvm_info("apb_seq", "Successfully created h_pkt", UVM_MEDIUM)
//     end
//     start_item(h_pkt);  
//     h_pkt.paddr = h_pkt.addr+1 ;
//     //h_pkt.pwdata = 49;
//     assert(h_pkt.randomize);
//     finish_item(h_pkt);
//     repeat(8)
//      a = a+1;
//     `uvm_info("apb_seq", "Finished write item h_pkt", UVM_MEDIUM)  
//   endtask 
 class mul_wr_seq extends apb_seq;
   `uvm_object_utils(mul_wr_seq)
  seq_item h_pkt;
  
  virtual apb_intf vif;
   function new(string name = "mul_wr_seq");
    super.new(name);
    `uvm_info("seq", "Inside apb_seq new", UVM_MEDIUM)
  endfunction
  
  virtual task body();
        h_pkt = seq_item::type_id::create("h_pkt");
    repeat(10) begin
    write();
    end
    h_pkt.paddr=0;
    //#10;
     repeat(10)
      begin
      read();
    end   
    
  endtask
  
   task write(); 
    `uvm_info("apb_seq", "Inside write task", UVM_MEDIUM)
    start_item(h_pkt);  
    h_pkt.paddr = h_pkt.paddr+1;
    h_pkt.pwrite =1;

    assert(h_pkt.randomize);
    finish_item(h_pkt);
    `uvm_info("apb_seq", "Finished write item h_pkt", UVM_MEDIUM) 
  endtask
   
   task read();     
     `uvm_info("apb_seq", "Inside write task", UVM_MEDIUM)
    start_item(h_pkt);  
    h_pkt.paddr = h_pkt.paddr+1;
    h_pkt.pwrite =0;
    finish_item(h_pkt);
     `uvm_info("apb_seq", "Finished read item h_pkt", UVM_MEDIUM) 

   endtask
   
endclass
    
class alternate_wr_rd extends apb_seq;
     `uvm_object_utils(alternate_wr_rd)
  seq_item h_pkt;
  int i=15;
  int j=15;
  virtual apb_intf vif;
   function new(string name = "alternate_wr_rd");
    super.new(name);
    `uvm_info("seq", "Inside alternate_wr_rd new", UVM_MEDIUM)
  endfunction
  
  task body();

    repeat(5) begin
    write();
 //   #10;
      read();
 //   #10;   
    end
    
  endtask
  
     task write(); 
     h_pkt = seq_item::type_id::create("h_pkt");

    `uvm_info("apb_seq", "Inside write task", UVM_MEDIUM)
    start_item(h_pkt);  
    h_pkt.paddr = i++;
    h_pkt.pwrite =1;

    assert(h_pkt.randomize);
    finish_item(h_pkt);
    `uvm_info("apb_seq", "Finished write item h_pkt", UVM_MEDIUM) 
  endtask
   
   task read();   
      h_pkt = seq_item::type_id::create("h_pkt");
     `uvm_info("apb_seq", "Inside write task", UVM_MEDIUM)
    start_item(h_pkt);  
    h_pkt.paddr = j++;
    h_pkt.pwrite =0;
    finish_item(h_pkt);
     `uvm_info("apb_seq", "Finished read item h_pkt", UVM_MEDIUM) 

   endtask
  
endclass
  
  
  
  