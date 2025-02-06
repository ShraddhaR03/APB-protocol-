class slave_agent_config extends uvm_object;
	`uvm_object_utils(slave_agent_config)

	uvm_active_passive_enum is_active;
	
	bit has_slave_monitor;


	function new(string name = "slave_agent_config");
		super.new(name);
		is_active = UVM_ACTIVE;
		 has_slave_monitor = 1'b1;
		 `uvm_info("slave_agent_config","Inside new",UVM_LOW)
	endfunction
endclass