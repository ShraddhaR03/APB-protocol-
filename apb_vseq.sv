class apb_vseq extends uvm_sequence;
  `uvm_object_utils(apb_vseq)
  `uvm_declare_p_sequencer(apb_vseqr)
    event sequence_done;

   apb_seq h_seq;
    mul_wr_seq    h_mul_wr_seq;
   alternate_wr_rd  h_alternate_wr_rd;
   
  function new(string name ="apb_vseq");
    super.new(name);
    `uvm_info(get_type_name(),"inside apb_vseq new",UVM_MEDIUM)
  endfunction
  
  task body();
    h_seq = apb_seq::type_id::create("h_seq");
    h_seq.start(p_sequencer.h_master_seqr);
              
    h_mul_wr_seq = mul_wr_seq::type_id::create("h_mul_wr_seq");
    h_mul_wr_seq.start(p_sequencer.h_master_seqr);
    h_alternate_wr_rd = alternate_wr_rd::type_id::create("h_alternate_wr_rd");
    h_alternate_wr_rd.start(p_sequencer.h_master_seqr);
   

  endtask 
endclass