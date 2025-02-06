interface apb_intf(input logic pclk,presetn);
  logic [31:0] paddr;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] pwdata;
  logic pready;
  logic [31:0] prdata;
  logic pslverr;
  
  
  property presetn_check ;
    @(posedge pclk)
    $fell(presetn) |->  (prdata == 32'h00000000 && pready == 1'b0 && pslverr == 1'b0);
endproperty
  
  //=> next clock
  
  property penable_check ;
    @(posedge pclk) 
    $rose(psel) |=>  $rose(penable);
endproperty
  
  property pready_check;
    @(posedge pclk) disable iff (!presetn)
    $rose(penable)|=> $rose(pready);
   // $rose(penable) $rose(pready);
endproperty
  
  
  property pwrite_check;
    @(posedge pclk) 
    $rose(pwrite) |->  (pwdata>0 && paddr>0);
endproperty
  
property pready_check2;
    @(posedge pclk) 
  $fell(penable) |-> $fell(pready);
endproperty
 
  
  
 assert property(presetn_check);
 assert property(penable_check);
  assert property(pready_check);
 assert property(pwrite_check);
//  assert property(pready_check2);
   
endinterface
