/* verilator lint_off WIDTH */
/* verilator lint_off LATCH */


module fpu_top (
    input logic clk_i,
    input logic [31:0] op_a_i,
    input logic [31:0] op_b_i,
    input logic [1:0]  fpu_op_i,
    input logic        alu_fpu_en_i,
    output logic [31:0] fpu_data_o
);

  logic [32:0] pre_a, pre_b;
  logic [3:0]  exception;
  logic [33:0] add_result;
  logic [31:0] exc_value,norm_value;
  
  assign fpu_data_o = (exception == 0)? norm_value : exc_value ;

  fpu_pre_norm prenorm (
  .clk_i(clk_i),
  .op_a_i(op_a_i), 
  .op_b_i(op_b_i),
  .fpu_op_i(fpu_op_i),
  .alu_fpu_en_i(alu_fpu_en_i),
  .pre_a_o(pre_a),
  .pre_b_o(pre_b),
  .exception_o(exception),
  .exception_value(exc_value)
  );

  fpu_add  addf (
    .pre_a_i(pre_a),
    .pre_b_i(pre_b),
    .exception_i(exception),
    .add_o(add_result)
    //.norm_en
  );

  fpu_post_norm normf (
    .add_i(add_result),
    .exception_i(exception),
    .norm_o(norm_value)
  );
endmodule






