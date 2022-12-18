module feedback_mux (
    input  logic [31:0] pc_four_i,
    input  logic [31:0] alu_data_i,
    input  logic [31:0] mem_data_i,
    input  logic [ 1:0] wb_sel_i,
    output logic [31:0] wb_data_o
);

  always_comb begin
    case (wb_sel_i)
      2'b00:   wb_data_o = alu_data_i;
      2'b01:   wb_data_o = mem_data_i;
      2'b10:   wb_data_o = pc_four_i;
      default: wb_data_o = 32'd0;
    endcase
  end
endmodule
