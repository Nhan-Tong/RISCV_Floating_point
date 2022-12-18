module immgen (
    input  logic [31:0] inst_i,
    input  logic [ 2:0] imm_op_i,
    output logic [31:0] immgen_o
);

  always_comb begin : pro_imm
    case (imm_op_i)

      3'b000: 
      immgen_o = {{21{inst_i[31]}}, inst_i[30:20]};  // I-type

      3'b001: 
      immgen_o = {{21{inst_i[31]}}, inst_i[30:25], inst_i[11:7]};  // S-type

      3'b010:
      immgen_o = {{20{inst_i[31]}}, inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};  // B-type

      3'b011: immgen_o = {inst_i[31:12], 12'd0};  // U-type	

      3'b100:
      immgen_o = {{12{inst_i[31]}}, inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};  // J-type	

      3'b101: immgen_o = 0;  // R_type

      default: immgen_o = inst_i;
    endcase
  end

endmodule
