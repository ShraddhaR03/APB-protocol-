class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)
   master_seqr		h_master_seqr;
   apb_driver	  h_apb_dri;
   master_monitor	h_master_mon;
    //scoreboard h_scbd;
  master_agent_config h_master_agent_config;
  
  function new(string name = "master_agent",uvm_component parent);
    super.new(name,parent);
    `uvm_info(get_type_name(),"inside master_agent new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"inside master_agent build_phase",UVM_MEDIUM)
    
    if(!uvm_config_db#(master_agent_config)::get(this,"","master_agent_config",h_master_agent_config)) begin
			`uvm_fatal("h_master_agent_config","master_agent_config not collected properly")
		end	
    
	if(h_master_agent_config.has_master_seqr == 1) begin
    h_master_seqr = master_seqr::type_id::create("h_master_seqr",this);
	 end
  	if(h_master_agent_config.has_master_driver == 1) begin
    h_apb_dri = apb_driver::type_id::create("h_apb_dri",this);
	 end  
      	if(h_master_agent_config.has_master_monitor == 1) begin
    h_master_mon = master_monitor::type_id::create("h_master_mon",this);
	 end 
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"inside master_agent connect_phase",UVM_MEDIUM)
    h_apb_dri.seq_item_port.connect(h_master_seqr.seq_item_export);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"inside master_agent run_phase",UVM_MEDIUM)
  endtask
  
endclass