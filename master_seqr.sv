class master_seqr extends uvm_sequencer #(seq_item);
  `uvm_component_utils(master_seqr)
  function new(string name="master_seqr",uvm_component parent);
    super.new(name,parent);
    `uvm_info(get_type_name(),"inside master_seqr",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"inside master_seqr build_phase",UVM_MEDIUM)
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"inside master_vseqr connect_phase",UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"inside master_seqr run_phase",UVM_MEDIUM)
  endtask
endclass