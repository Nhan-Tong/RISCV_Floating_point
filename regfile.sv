module regfile (
  input logic 			    clk_i,
  input logic  [4:0]  	rs1_addr_i,
  input logic  [4:0] 	  rs2_addr_i,
  input logic  [4:0] 	  rd_addr_i,
  input logic  [31:0] 	rd_data_i,
  input logic  			    rd_wren_i,
  output logic [31:0] 	rs1_data_o,
  output logic [31:0] 	rs2_data_o
  );
 
  logic [31:0] rf_mem [0:31];

  always_ff @(posedge clk_i) begin 
    if(rd_wren_i)
      rf_mem [rd_addr_i] <= rd_data_i;
    else 
      rf_mem [rd_addr_i] <= rf_mem [rd_addr_i];
  end 
  initial begin
   $writememh ("./include/regfile.data",rf_mem);
  end

  assign rs1_data_o = (rs1_addr_i !=0 )? rf_mem[rs1_addr_i] : 0 ;
  assign rs2_data_o = (rs2_addr_i !=0 )? rf_mem[rs2_addr_i] : 0 ;

endmodule 
