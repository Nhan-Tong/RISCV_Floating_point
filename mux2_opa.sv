module mux2_opa (
    input  logic [31:0] pc_i,
    input  logic [31:0] rs1_data_i,
    input  logic        op_a_sel_i,
    output logic [31:0] operand_a_o
);

  always_comb begin
    if (op_a_sel_i) operand_a_o = pc_i;
    else operand_a_o = rs1_data_i;
  end
endmodule


