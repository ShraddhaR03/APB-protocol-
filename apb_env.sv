class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)
  apb_vseqr		h_vseqr;
  master_agent		h_master_agent;
  slave_agent		h_slave_agent;
  scoreboard	h_scbd;
  master_monitor h_master_monitor;
  slave_monitor h_slave_monitor;
  env_config h_env_cfg;
  coverage_collector h_cov;
  
  function new(string name ="apb_env",uvm_component parent);
    super.new(name,parent);
    `uvm_info("ENV_CLASS","inside apb_env new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("env class","inside apb_env build_phase",UVM_MEDIUM)
    h_cov  =  coverage_collector::type_id::create("h_cov",this);
   
		if(!uvm_config_db#(env_config)::get(this,"","env_config",h_env_cfg)) begin
			`uvm_fatal("env","env config not collected properly")
		end

		h_env_cfg.build_configs();

		if(h_env_cfg.has_master_agent == 1) begin
    h_master_agent = master_agent::type_id::create("h_master_agent",this);
	        end

		if(h_env_cfg.has_slave_agent == 1) begin
    h_slave_agent = slave_agent::type_id::create("h_slave_agent",this);
	 	 end
    		if(h_env_cfg.has_vseqr == 1) begin
               h_vseqr = apb_vseqr::type_id::create("h_vseqr",this);
            end
        		if(h_env_cfg.has_scoreboard == 1) begin
                    h_scbd	= scoreboard::type_id::create("h_scbd",this);
                end  

					// h_scbd	= scoreboard::type_id::create("h_scbd",this);
  endfunction
  
//   function void connect_phase(uvm_phase phase);
//     `uvm_info("env class","inside apb_env connect_phase",UVM_MEDIUM) 
//     h_vseqr.h_master_seqr = h_master_agent.h_master_seqr; 
//     h_master_agent.h_master_mon.master_mon2scbd.connect(h_scbd.master_mon2sb_imp_port);
//     h_slave_agent.h_slave_mon.slave_mon2scbd.connect(h_scbd.slave_mon2sb_imp_port);     
//   endfunction
// k
// endclass  
//   task run_phase(uvm_phase phase);
//     super.run_phase(phase);
//     `uvm_info("Env Class","inside apb_env run_phase",UVM_MEDIUM)
  //   endtask
  
    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ENV_CLASS", "inside apb_env connect_phase", UVM_MEDIUM)
    
    if (h_env_cfg.has_master_agent && h_env_cfg.has_vseqr) begin
      h_vseqr.h_master_seqr = h_master_agent.h_master_seqr;
      `uvm_info("ENV_CLASS", "Connected master sequencer to virtual sequencer", UVM_MEDIUM)
    end
    
    if (h_env_cfg.has_master_agent && h_env_cfg.has_scoreboard) begin
      h_master_agent.h_master_mon.master_mon2scbd.connect(h_scbd.master_mon2sb_imp_port);
      `uvm_info("ENV_CLASS", "Connected master monitor to scoreboard", UVM_MEDIUM)
      
    end
    
    if (h_env_cfg.has_slave_agent && h_env_cfg.has_scoreboard) begin
      h_slave_agent.h_slave_mon.slave_mon2scbd.connect(h_scbd.slave_mon2sb_imp_port);
      `uvm_info("ENV_CLASS", "Connected slave monitor to scoreboard", UVM_MEDIUM)
    end
      h_master_agent.h_master_mon.master_mon2scbd.connect(h_cov.analysis_export);
      h_slave_agent.h_slave_mon.slave_mon2scbd.connect(h_cov.analysis_export);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("ENV_CLASS", "inside apb_env run_phase", UVM_MEDIUM)
  endtask
endclass