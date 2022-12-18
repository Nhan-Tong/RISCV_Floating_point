module mux2_opb (
   input logic [31:0] imm_i,
   input logic [31:0] rs2_data_i,
   input logic op_b_sel_i,
   output logic [31:0] operand_b_o
);

  always_comb begin
    if (op_b_sel_i) operand_b_o = imm_i;
    else operand_b_o = rs2_data_i;
  end
endmodule

