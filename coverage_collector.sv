class coverage_collector extends uvm_subscriber#(seq_item);
  `uvm_component_utils(coverage_collector)
  seq_item h_pkt;
  
  
  
//   covergroup cg;
    
//     cp1:coverpoint h_pkt.wr{bins b1[1]={[0:1]};}
//     cp2:coverpoint h_pkt.rd{bins b2[1]={[0:1]};}
//     cp3:coverpoint h_pkt.data_in{bins b3[1]={[0:7]};}
//     cp4:coverpoint h_pkt.data_out{bins b4[1]={[0:7]};}
//   endgroup
  
//     covergroup cg;
//       option.per_instance=1;
    
//     cp1:coverpoint h_pkt.pwdata;
//     cp2:coverpoint h_pkt.prdata;
//     cp3:coverpoint h_pkt.pwrite;
//     cp4:coverpoint h_pkt.psel;
//           cp5:coverpoint h_pkt.penable;
//           cp6:coverpoint h_pkt.presetn;
//           cp7:coverpoint h_pkt.paddr;
//           cp8:coverpoint h_pkt.pready;

//   endgroup

      covergroup cg;
      option.per_instance=1;
    
        cp1:coverpoint h_pkt.pwdata {bins b1[4]={[0:2147483647 ]};}
        cp2:coverpoint h_pkt.prdata {bins b2[1]={[0:1]};}
        cp3:coverpoint h_pkt.pwrite {bins b3[1]={[0:1]};}
        cp4:coverpoint h_pkt.psel {bins b4[1]={[0:1]};}
        cp5:coverpoint h_pkt.penable {bins b5[1]={[0:1]};}
        //cp6:coverpoint h_pkt.presetn {bins b6[1]={[0:1]};}
        cp7:coverpoint h_pkt.paddr {bins b7[3]={[0:20]};}
        cp8:coverpoint h_pkt.pready {bins b8[1]={[0:1]};}

  endgroup
  
  function new(string name = "coverage_collector",uvm_component parent);
    super.new(name, parent);
     h_pkt=seq_item::type_id::create("h_pkt");
    `uvm_info("coverage_collector","Inside apb coverage_collector",UVM_MEDIUM)
    cg=new();
   endfunction
  
  virtual function void write(seq_item t);
    h_pkt=t;
    cg.sample();
    `uvm_info("coverage_collector",$sformatf("the functional coverage is :%d",cg.get_coverage),UVM_MEDIUM);
   
  endfunction
  
  
endclass

