class apb_vseqr extends uvm_sequencer;
  `uvm_component_utils(apb_vseqr)
   master_seqr  h_master_seqr;
  
  function new(string name ="apb_vseqr",uvm_component parent);
    super.new(name,parent);
    `uvm_info(get_type_name(),"inside apb_vseqr new",UVM_MEDIUM)
  endfunction
  
  task body();
    h_master_seqr = master_seqr::type_id::create("h_master_seqr",this);
    
  endtask
  
endclass