module pc_unit (
    input  logic         clk_i,
    input  logic         rst_ni,
    input  logic         br_sel_i,
    input  logic [31:0]  alu_data_i,
    input  logic [31:0]  pc_four_i,
    output logic [31:0]  pc_o
);

  logic [31:0] nxt_pc;

  always_comb begin
    if (br_sel_i) nxt_pc = alu_data_i;
    else nxt_pc = pc_four_i;
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) pc_o <= 0;
    else pc_o <= nxt_pc;
  end

endmodule
