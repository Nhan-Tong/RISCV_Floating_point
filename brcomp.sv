module brcomp ( 
  input logic [31:0] rs1_data_i,
  input logic [31:0] rs2_data_i,
  input logic        br_unsigned_i,
  output logic       br_less_o,
  output logic       br_equal_o
 );

  //  -------------------------------------------------------------------------------------------

  logic L_u1,L_s1,E_u1,E_s1,G_u1,G_s1;
  assign br_less_o  = (br_unsigned_i == 1'b1)? ((L_u1==1'b1)?1:0) : ((L_s1==1'b1)?1:0 ); 
  assign br_equal_o = (br_unsigned_i == 1'b1)? ((E_u1==1'b1)?1:0) : ((E_s1==1'b1)?1:0 );
  /* verilator lint_off UNUSED */
  logic br_not_used;  
  assign br_not_used = G_u1 | G_s1;
  /* verilator lint_on UNUSED */

  //  -------------------------------------------------------------------------------------------
 
  sltu_32b sltu_32b_alu1 (  
	.L (L_u1), .E(E_u1), .G (G_u1),
    .a0  (rs1_data_i[0]),  .a1  (rs1_data_i[1]),  .a2  (rs1_data_i[2]),    .a3  (rs1_data_i[3]),	.a4  (rs1_data_i[4]),  .a5  (rs1_data_i[5]),
    .a6  (rs1_data_i[6]),  .a7  (rs1_data_i[7]),  .a8  (rs1_data_i[8]),    .a9  (rs1_data_i[9]),	.a10 (rs1_data_i[10]), .a11 (rs1_data_i[11]),
	.a12 (rs1_data_i[12]), .a13 (rs1_data_i[13]), .a14 (rs1_data_i[14]),   .a15 (rs1_data_i[15]),	.a16 (rs1_data_i[16]), .a17 (rs1_data_i[17]),
	.a18 (rs1_data_i[18]), .a19 (rs1_data_i[19]), .a20 (rs1_data_i[20]),   .a21 (rs1_data_i[21]),   .a22 (rs1_data_i[22]), .a23 (rs1_data_i[23]),
	.a24 (rs1_data_i[24]), .a25 (rs1_data_i[25]), .a26 (rs1_data_i[26]),   .a27 (rs1_data_i[27]),   .a28 (rs1_data_i[28]), .a29 (rs1_data_i[29]),
	.a30 (rs1_data_i[30]), .a31 (rs1_data_i[31]),
	.b0  (rs2_data_i[0]),  .b1  (rs2_data_i[1]), .b2  (rs2_data_i[2]),    .b3  (rs2_data_i[3]),	    .b4  (rs2_data_i[4]),  .b5  (rs2_data_i[5]),
	.b6  (rs2_data_i[6]),  .b7  (rs2_data_i[7]), .b8  (rs2_data_i[8]),    .b9  (rs2_data_i[9]),	    .b10 (rs2_data_i[10]), .b11 (rs2_data_i[11]),
	.b12 (rs2_data_i[12]), .b13 (rs2_data_i[13]),.b14 (rs2_data_i[14]),   .b15 (rs2_data_i[15]),    .b16 (rs2_data_i[16]), .b17 (rs2_data_i[17]),
	.b18 (rs2_data_i[18]), .b19 (rs2_data_i[19]),.b20 (rs2_data_i[20]),   .b21 (rs2_data_i[21]),    .b22 (rs2_data_i[22]), .b23 (rs2_data_i[23]),
	.b24 (rs2_data_i[24]), .b25 (rs2_data_i[25]),.b26 (rs2_data_i[26]),   .b27 (rs2_data_i[27]),    .b28 (rs2_data_i[28]), .b29 (rs2_data_i[29]),
	.b30 (rs2_data_i[30]), .b31 (rs2_data_i[31])
	);

  //  -------------------------------------------------------------------------------------------

  slt_32b slt_32b_alu1 (  
	.L (L_s1), .E(E_s1), .G (G_s1),
    .a0  (rs1_data_i[0]),  .a1  (rs1_data_i[1]),  .a2  (rs1_data_i[2]),    .a3  (rs1_data_i[3]),	.a4  (rs1_data_i[4]),  .a5  (rs1_data_i[5]),
    .a6  (rs1_data_i[6]),  .a7  (rs1_data_i[7]),  .a8  (rs1_data_i[8]),    .a9  (rs1_data_i[9]),	.a10 (rs1_data_i[10]), .a11 (rs1_data_i[11]),
	.a12 (rs1_data_i[12]), .a13 (rs1_data_i[13]), .a14 (rs1_data_i[14]),   .a15 (rs1_data_i[15]),	.a16 (rs1_data_i[16]), .a17 (rs1_data_i[17]),
	.a18 (rs1_data_i[18]), .a19 (rs1_data_i[19]), .a20 (rs1_data_i[20]),   .a21 (rs1_data_i[21]),   .a22 (rs1_data_i[22]), .a23 (rs1_data_i[23]),
	.a24 (rs1_data_i[24]), .a25 (rs1_data_i[25]), .a26 (rs1_data_i[26]),   .a27 (rs1_data_i[27]),   .a28 (rs1_data_i[28]), .a29 (rs1_data_i[29]),
	.a30 (rs1_data_i[30]), .a31 (rs1_data_i[31]),
	.b0  (rs2_data_i[0]),  .b1  (rs2_data_i[1]), .b2  (rs2_data_i[2]),    .b3  (rs2_data_i[3]),	    .b4  (rs2_data_i[4]),  .b5  (rs2_data_i[5]),
	.b6  (rs2_data_i[6]),  .b7  (rs2_data_i[7]), .b8  (rs2_data_i[8]),    .b9  (rs2_data_i[9]),	    .b10 (rs2_data_i[10]), .b11 (rs2_data_i[11]),
	.b12 (rs2_data_i[12]), .b13 (rs2_data_i[13]),.b14 (rs2_data_i[14]),   .b15 (rs2_data_i[15]),    .b16 (rs2_data_i[16]), .b17 (rs2_data_i[17]),
	.b18 (rs2_data_i[18]), .b19 (rs2_data_i[19]),.b20 (rs2_data_i[20]),   .b21 (rs2_data_i[21]),    .b22 (rs2_data_i[22]), .b23 (rs2_data_i[23]),
	.b24 (rs2_data_i[24]), .b25 (rs2_data_i[25]),.b26 (rs2_data_i[26]),   .b27 (rs2_data_i[27]),    .b28 (rs2_data_i[28]), .b29 (rs2_data_i[29]),
	.b30 (rs2_data_i[30]), .b31 (rs2_data_i[31])
	);
 endmodule 
