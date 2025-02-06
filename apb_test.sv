class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  apb_env h_env;
  apb_vseq	h_vseq;
  apb_seq	h_seq;
  apb_vseqr h_vseqr;
  env_config h_env_cfg;
  master_agent_config  h_master_agent_config;
  slave_agent_config h_slave_agent_config;
  
  function new(string name ="apb_test",uvm_component parent);
    super.new(name,parent);
    `uvm_info("apb_test","inside apb_test new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("apb_test","inside apb_test build_phase",UVM_MEDIUM)
    h_vseq = apb_vseq::type_id::create("h_vseq");
    h_seq = apb_seq::type_id::create("h_seq");
    h_env = apb_env::type_id::create("h_env",this);
    h_env_cfg = env_config::type_id::create("h_env_cfg");
    h_master_agent_config = master_agent_config::type_id::create("h_master_agent_config");
    h_slave_agent_config = slave_agent_config::type_id::create("h_slave_agent_config");
    uvm_config_db#(env_config )::set(this,"*","env_config",h_env_cfg);
    uvm_config_db#(master_agent_config )::set(this,"*","master_agent_config",h_master_agent_config);
    uvm_config_db#(slave_agent_config )::set(this,"*","slave_agent_config",h_slave_agent_config); 

    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("apb_test","inside apb_test connect_phase",UVM_MEDIUM)
  endfunction
  
    function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
      `uvm_info("test","Inside apb_test end_of_elaboration_phase",UVM_MEDIUM)
    uvm_top.print_topology();
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("apb_test","inside apb_test run_phase",UVM_MEDIUM)
    //#50;
    
       h_vseq.start(h_env.h_vseqr);
 //wait(h_vseq.sequence_done.triggered);      
   
    #40;
        phase.drop_objection(this);

  endtask
endclass
  
  