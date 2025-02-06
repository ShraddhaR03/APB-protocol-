class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  `uvm_analysis_imp_decl(_ip_imp)
  `uvm_analysis_imp_decl(_op_imp)
  
  uvm_analysis_imp_ip_imp #(seq_item, scoreboard) master_mon2sb_imp_port;
  uvm_analysis_imp_op_imp #(seq_item, scoreboard) slave_mon2sb_imp_port;
  
  int fail_count, pass_count;
  seq_item h_pkt;
  int ip_queue[$];
  int op_queue[$];
  
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("scoreboard", "Inside apb scoreboard new", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("scoreboard", "Inside scoreboard build_phase", UVM_MEDIUM)
    master_mon2sb_imp_port = new("master_mon2sb_imp_port", this);
    slave_mon2sb_imp_port = new("slave_mon2sb_imp_port", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("scoreboard", "Inside scoreboard connect_phase", UVM_MEDIUM)
  endfunction
  
  function void write_ip_imp(seq_item h_pkt);
    if(h_pkt.pwdata > 0)
      begin
    ip_queue.push_back(h_pkt.pwdata);
    `uvm_info("scoreboard", $sformatf("inside the scoreboard master_monitor values are %0d item", h_pkt.pwdata), UVM_MEDIUM)

      end
  endfunction
  
  function void write_op_imp(seq_item h_pkt);

    op_queue.push_back(h_pkt.prdata);
    `uvm_info("scoreboard", $sformatf("inside the scoreboard slave_monitor values are %0d item", h_pkt.prdata), UVM_MEDIUM)


     
  endfunction
  
  task run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info("scoreboard", "Inside scoreboard run_phase", UVM_MEDIUM)
  phase.raise_objection(this);
  forever begin
    wait(ip_queue.size() > 0);
    wait(op_queue.size() > 0);
    compare();
  end
 phase.drop_objection(this);
endtask

  
  // Compare task
  virtual task compare();
    int exp_data;
    int act_data;
    
    act_data = op_queue.pop_front();
    exp_data = ip_queue.pop_front();
    
    if (exp_data == act_data) begin
      pass_count++;
      `uvm_info("compare", $sformatf("PASSED, at time:%0t EXP_data %0d match with ACT_data %0d", $time, exp_data,act_data), UVM_LOW)
    end else begin
      fail_count++;
      `uvm_info("compare", $sformatf("FAILED, at time:%0t EXP_data=%0d does not match with ACT_data=%0d", $time, exp_data, act_data), UVM_LOW)
    end
    reportphase();
  endtask
  
  virtual function void reportphase(  );
    `uvm_info("report_phase", $sformatf("scoreboard result: passed = %0d, failed = %0d", pass_count, fail_count), UVM_LOW)
    if (fail_count > 0) begin
      `uvm_error("report_phase", $sformatf("test failed with %0d mismatches", fail_count))
    end
    else
      `uvm_info("report_phase", $sformatf("ALl test cases are sucessfully passed  with %0d matched", pass_count),UVM_LOW)
      
      `uvm_info("REPORT_PHASE","PROJECT COMPLETE SUCESSFULLY", UVM_LOW)
    
      
  endfunction

endclass
