module sys_clk(clk_o,rst_ni);

output logic clk_o, rst_ni;

// clock
  initial begin
    pclk = 0;
    forever #50 pclk =~ pclk;
  end

// initial preset
  initial begin
    rst_ni =  1'b1;
    #50;
    rst_ni =  1'b0;
    #50;
    rst_ni =  1'b1;
  end
endmodule