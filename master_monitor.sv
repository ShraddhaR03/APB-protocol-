  class master_monitor extends uvm_monitor;
  `uvm_component_utils(master_monitor)
  virtual apb_intf vif;
  seq_item h_pkt;
    
  uvm_analysis_port#(seq_item)  master_mon2scbd;
  function new(string name="master_monitor",uvm_component parent);
    super.new(name,parent);
    `uvm_info(get_type_name(),"inside master_monitor new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"inside master_monitor build_phase",UVM_MEDIUM)
    master_mon2scbd = new("master_mon2scbd",this);
    if(!uvm_config_db #(virtual apb_intf):: get(this,"","intf1",vif))
      begin
      `uvm_fatal("master_mon","danger")
    end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"inside master_monitor connect_phase",UVM_MEDIUM)
  endfunction
  
//   task run_phase(uvm_phase phase);
//     super.run_phase(phase);
//     `uvm_info(get_type_name(),"inside master_monitor run_phase",UVM_MEDIUM)
//     forever begin
//       if(vif.presetn==1 && vif.psel == 1 && vif.penable == 1 && vif.pwrite ==1)
//         @(posedge vif.pclk)
//         begin
//           h_pkt = seq_item::type_id::create("h_pkt");
//         h_pkt.pwdata=vif.pwdata;
//        // h_pkt.prdata=vif.prdata;
//         h_pkt.pwrite = vif.pwrite;
//            h_pkt.penable=vif.penable;
//           h_pkt.psel = vif.psel;
//         h_pkt.paddr=vif.paddr;
//       master_mon2scbd.write(h_pkt);
//         end
//     end
//     endtask
    task run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name(),"inside master_monitor run_phase",UVM_MEDIUM)
  forever begin
    @(posedge vif.pclk)
    if (vif.presetn == 1  && vif.pwrite == 1 && vif.penable == 1 && vif.pwdata >0 ) begin
      h_pkt = seq_item::type_id::create("h_pkt");
      h_pkt.pwdata = vif.pwdata;
      h_pkt.pwrite = vif.pwrite;
      h_pkt.penable = vif.penable;
      h_pkt.psel = vif.psel;
      h_pkt.paddr = vif.paddr;
      master_mon2scbd.write(h_pkt);
    end
  end
endtask

endclass