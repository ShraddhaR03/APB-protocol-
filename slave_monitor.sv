class slave_monitor extends uvm_monitor;
  `uvm_component_utils(slave_monitor)
   virtual apb_intf vif;
  seq_item h_pkt;
  uvm_analysis_port#(seq_item)  slave_mon2scbd;
  function new(string name="slave_monitor",uvm_component parent);
    super.new(name,parent);
    `uvm_info(get_type_name(),"inside slave_monitor new",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info(get_type_name(),"inside master_monitor build_phase",UVM_MEDIUM)
    slave_mon2scbd = new("slave_mon2scbd",this);
    if(!uvm_config_db #(virtual apb_intf):: get(this,"","intf1",vif)) begin
      `uvm_fatal("slave_mon","danger")
    end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"inside slave_monitor connect_phase",UVM_MEDIUM)
  endfunction
  
  task  run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"inside slave_monitor run_phase",UVM_MEDIUM)
     forever begin
       @(posedge vif.pclk)
       if(vif.presetn==1 &&  vif.penable == 1 && vif.pwrite ==0  && vif.prdata >0)
        
        begin   
          h_pkt = seq_item::type_id::create("h_pkt");
          h_pkt.prdata=vif.prdata;
          h_pkt.penable=vif.penable;
          h_pkt.psel = vif.psel;
          h_pkt.pwrite = vif.pwrite;
 		  h_pkt.paddr=vif.paddr;
          slave_mon2scbd.write(h_pkt);
        end
    end
    endtask
endclass