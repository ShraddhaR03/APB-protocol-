// Code your testbench here
// or browse Examples
`include "apb_pkg.sv"
import apb_pkg ::*;
import uvm_pkg ::*;
`include "uvm_macros.svh"
`include "apb_intf.sv"

module tb_top();
  bit pclk,presetn;
  
  parameter CLOCK_PERIOD =5;
  parameter RESET_PERIOD =4;
  
  apb_intf intf(pclk,presetn);
  
   apb_design i_apb_design(.pclk(pclk),
                           .presetn(presetn),
                            .paddr(intf.paddr),
                            .psel(intf.psel),
                            .penable(intf.penable),
                            .pwrite(intf.pwrite),
                            .pwdata(intf.pwdata),
                            .pready(intf.pready),
                            .prdata(intf.prdata),
                            .pslverr(intf.pslverr)
                           );
  
  task clk_generation();
    pclk= 'b0;
    forever begin
      #(CLOCK_PERIOD/2) pclk=~pclk;
    end
  endtask
  
  task rst_generation();
    presetn= 'b1;
    #(RESET_PERIOD);
    presetn = 'b1;
  endtask
  
  initial begin
    clk_generation();
    end
  
  initial begin
    rst_generation();
  end
  
  initial begin
    uvm_config_db#(virtual apb_intf)::set(null,"*","intf1",intf);
    run_test("apb_test");
  end
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
  initial begin
    #900;
    $finish;
  end
  
endmodule
    
  
  