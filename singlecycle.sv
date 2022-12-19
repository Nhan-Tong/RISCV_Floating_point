module singlecycle (
    // inputs 
    input  logic        clk_i,
    input  logic        rst_ni,
    input  logic [31:0] io_sw_i,
    // outputs
    output logic [31:0] io_lcd_o,
    output logic [31:0] io_ledg_o,
    output logic [31:0] io_ledr_o,
    output logic [31:0] io_hex0_o,
    output logic [31:0] io_hex1_o,
    output logic [31:0] io_hex2_o,
    output logic [31:0] io_hex3_o,
    output logic [31:0] io_hex4_o,
    output logic [31:0] io_hex5_o,
    output logic [31:0] io_hex6_o,
    output logic [31:0] io_hex7_o
);

  //// wire -----------------------------------------------------------------------------check

  logic [31:0] inst;
  logic [31:0] alu_data;
  logic [31:0] pc;
  logic [31:0] wb_data;
  logic [31:0] rs1_data, rs2_data;
  logic [31:0] operand_a, operand_b;
  logic [31:0] imm;
  logic [31:0] mem_data;
  logic [ 2:0] imm_sel;
  logic [ 3:0] alu_op; // alu option
  logic [ 1:0] wb_sel;
  logic [ 3:0] ls_op; // load store option
  logic        br_sel;
  logic        br_unsigned;
  logic        rf_wren;
  logic op_a_sel, op_b_sel;
  logic br_less;
  logic br_equal;
  logic mem_wren;

  //// module control unit-----------------------------------------------------------------------------check
  ctrl_unit ctrl_unit1 (
      .ls_op_o      (ls_op),
      .inst_i       (inst),
      .br_less_i    (br_less),
      .br_equal_i   (br_equal),
      .imm_sel_o    (imm_sel),
      .br_sel_o     (br_sel),
      .br_unsigned_o(br_unsigned),
      .rf_wren_o    (rf_wren),
      .op_a_sel_o   (op_a_sel),
      .op_b_sel_o   (op_b_sel),
      .alu_op_o     (alu_op),
      .mem_wren_o   (mem_wren),
      .wb_sel_o     (wb_sel)
  );
  ////////module pc unit------------------------------------------------------------------------------ check
  pc_unit pc_unit1 (
      .clk_i     (clk_i),
      .rst_ni    (rst_ni),
      .br_sel_i  (br_sel),
      .alu_data_i(alu_data),
      .pc_four_i (pc + 32'd4),
      .pc_o      (pc)
  );

  //// module instruction memory---------------------------------------------------------------------------check
  inst_memory inst_memory1 (
      .clk_i   (clk_i),
      .rst_ni  (rst_ni),
      .paddr_i (pc[13:0]),
      .prdata_o(inst)
  );
  //// module regfile --------------------------------------------------------------------------------------- check
  regfile regfile1 (
      .clk_i     (clk_i),
      .rs1_addr_i(inst[19:15]),
      .rs2_addr_i(inst[24:20]),
      .rd_addr_i (inst[11:7]),
      .rd_data_i (wb_data),
      .rf_wren_i (rf_wren),
      .rs1_data_o(rs1_data),
      .rs2_data_o(rs2_data)
  );
  /// module mux2_opa------------------------------------------------------------------------------------------check
  mux2_opa mux2_opa1 (
      .pc_i       (pc),
      .rs1_data_i (rs1_data),
      .op_a_sel_i (op_a_sel),
      .operand_a_o(operand_a)

  );
  // module mux2_opb------------------------------------------------------------------------------------------check
  mux2_opb mux2_opb1 (
      .imm_i      (imm),
      .rs2_data_i (rs2_data),
      .op_b_sel_i (op_b_sel),
      .operand_b_o(operand_b)

  );
  // module immgen--------------------------------------------------------------------------------------------check
  immgen immgen1 (
      .inst_i  (inst),
      .imm_op_i(imm_sel),
      .immgen_o   (imm)
  );
  // module brcomp ---------------------------------------------------------------------------------------------check
  brcomp brcomp1 (
      .rs1_data_i   (rs1_data),
      .rs2_data_i   (rs2_data),
      .br_unsigned_i(br_unsigned),
      .br_less_o    (br_less),
      .br_equal_o   (br_equal)
  );
  // module ALU-------------------------------------------------------------------------------------------------check
  ALU alu1 (
      .operand_a_i(operand_a),
      .operand_b_i(operand_b),
      .alu_op_i   (alu_op),
      .alu_data_o (alu_data)
  );

  // module memory control-------------------------------------------------------------------------------------------------?
  memory_control lsc1 (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .ls_op_i  (ls_op),
      .addr_i   (alu_data[11:0]),
      .lsc_wren_i(mem_wren),
      .st_data_i(rs2_data),
      .sw_i     (io_sw_i),
      .mem_data_o(mem_data),
      .io_lcd_o (io_lcd_o),
      .io_ledg_o(io_ledg_o),
      .io_ledr_o(io_ledr_o),
      .io_hex0_o(io_hex0_o),
      .io_hex1_o(io_hex1_o),
      .io_hex2_o(io_hex2_o),
      .io_hex3_o(io_hex3_o),
      .io_hex4_o(io_hex4_o),
      .io_hex5_o(io_hex5_o),
      .io_hex6_o(io_hex6_o),
      .io_hex7_o(io_hex7_o)
  );
  // module mux3------------------------------------------------------------------------------------------------check
  feedback_mux mux3to1 (
      .wb_sel_i  (wb_sel),
      .pc_four_i (pc + 32'd4),
      .alu_data_i(alu_data),
      .mem_data_i (mem_data),
      .wb_data_o (wb_data)
  );


endmodule
