module mux2_fpu_alu (
    input  logic [31:0] alu_i,
    input  logic [31:0] fpu_i,
    input  logic        alu_fpu_en_i,
    output logic [31:0] result_o
);

  always_comb begin
    if (alu_fpu_en_i) result_o = fpu_i;
    else result_o = alu_i;
  end
endmodule


