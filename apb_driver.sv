class apb_driver extends uvm_driver #(seq_item);
  `uvm_component_utils(apb_driver)
  seq_item h_pkt;
  
  virtual apb_intf vif;
  
  function new(string name="apb_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "inside apb_driver new", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "inside apb_driver build_phase", UVM_MEDIUM)
    if (!uvm_config_db#(virtual apb_intf)::get(this, "", "intf1", vif)) begin
      `uvm_fatal("ip_driver", "virtual intf instance not collected properly")
    end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "inside apb_driver connect_phase", UVM_MEDIUM)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "inside apb_driver run_phase", UVM_MEDIUM)
    
   
       forever begin
      @(posedge vif.pclk);
      seq_item_port.get_next_item(h_pkt);
          idle_state();
         drive_transfer(h_pkt);
       //  @(posedge vif.pclk);
         setup_state();
       //  @(posedge vif.pclk);
         access_state();
   
         `uvm_info("apb_driver",$sformatf("packet in the driver = %s item",h_pkt.sprint()),UVM_MEDIUM)
      seq_item_port.item_done();
       end
  endtask
  
//   task write();
//     // idle phase if psel is 0
     
        
//         vif.psel <= 0;
//         vif.penable <= 0;
     
      
//       // setup phase
//       //else if (h_pkt.penable == 0) 
//     forever begin
//               @(posedge vif.pclk);

        
//         vif.psel <= 1;
//         vif.paddr <= h_pkt.paddr;
//         vif.pwrite <= 1;
//         vif.pwdata <= h_pkt.pwdata;
//         vif.penable <= 0;
//     end
         
//       //Access Phase
//       //else if (h_pkt.penable == 1) 
//     forever begin
//     @(posedge vif.pclk);
//         vif.psel <= 1;
//         vif.paddr <= h_pkt.paddr;
//         vif.pwrite <= 1;
//         vif.pwdata <= h_pkt.pwdata;
//         vif.penable <= 1;
//         end
//   endtask
  
  
//    task read();
     
        
//         vif.psel <= 0;
//         vif.penable <= 0;
      
//       // setup phase
//      forever begin
//         @(posedge vif.pclk); 
//         vif.psel <= 1;
//         //vif.paddr <= h_pkt.paddr;
//         //vif.pwrite <= 0;
//         //vif.pwdata <= h_pkt.pwdata;
//         vif.penable <= 0;
//      end
         
//       //Access Phase
//       //else if (h_pkt.penable == 1) 
//      forever begin
//        @(posedge vif.pclk);
//         vif.psel <= 1;
//        // vif.paddr <= h_pkt.paddr;
//         //vif.pwrite <= 0;
//        // vif.pwdata <= h_pkt.pwdata;
//         vif.penable <= 1;
//         //vif.prdata <=1;
//         end
//   endtask
  
  task drive_transfer(seq_item h_pkt);
    vif.paddr<=h_pkt.paddr;
    vif.pwdata<=h_pkt.pwdata;
    vif.pwrite<=h_pkt.pwrite;
  endtask
  
  task idle_state();
    @(posedge vif.pclk);
    vif.psel<='b0;
    vif.penable<='b0;
  endtask
  
  task setup_state();
    @(posedge vif.pclk);
    vif.psel <= 1;
    vif.penable <= 0;
  endtask
  
  task access_state();
    @(posedge vif.pclk);
    vif.psel <= 1;
    vif.penable<= 1;
  endtask
  
  
endclass