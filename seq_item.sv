class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item)
  
   bit psel;
   bit penable;
   bit pwrite;
   bit [31:0] paddr;
 rand bit [31:0] pwdata;
  bit [31:0] prdata;
  bit pready;
  
//   constraint addr_range { paddr inside {[32'h00000000:32'hFFFFFFFF]}; }
//   constraint data_range { pwdata inside {[32'h00000000:32'hFFFFFFFF]}; }
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
endclass