class slave_agent extends uvm_agent;
  `uvm_component_utils(slave_agent)
  slave_monitor h_slave_mon;
      //scoreboard h_scbd;
     slave_agent_config   h_slave_agent_config;

  
  function new(string name ="slave_agent",uvm_component parent);
    super.new(name,parent);
    `uvm_info(get_type_name(),"Inside slave_agent new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"Inside slave_agent build_phase",UVM_MEDIUM)
    
    if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",h_slave_agent_config)) begin
			`uvm_fatal("env","slave_agent_config not collected properly")
		end
	
    if(h_slave_agent_config.has_slave_monitor == 1) begin
    h_slave_mon= slave_monitor::type_id::create("h_slave_mon",this);
	 end 
  endfunction
  
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info(get_type_name(),"Inside slave_agent connect_phase",UVM_MEDIUM)
  endfunction
  
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      `uvm_info(get_type_name(),"Inside slave_agent run_phase",UVM_MEDIUM)
    endtask
  
endclass