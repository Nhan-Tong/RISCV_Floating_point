module ALU (
  // inputs
  input  logic [31:0] operand_a_i,
  input  logic [31:0] operand_b_i,
  input  logic [3:0] alu_op_i,
  // outputs
  output logic [31:0] alu_data_o	
 );

  // variables declaration -------------------------------------------------------------------------------------------
  
  logic [31:0] slt_tmp;
  logic [31:0] sltu_tmp;
  logic [31:0] srl_tmp;	
  logic        L_u,L_s;
  /* verilator lint_off UNUSED */
  logic        br_not_used;
  logic        E_u,E_s,G_u,G_s;
  /* verilator lint_on UNUSED */

  typedef enum logic [3:0]{
	A_ADD	=	4'h0,
	A_SUB	=	4'h1,
	A_SLT   =	4'h2,
	A_SLTU	=	4'h3,
	A_XOR	=	4'h4,
	A_OR	=	4'h5,
	A_AND	=	4'h6,
	A_SLL	=	4'h7,
	A_SRL	=	4'h8,
	A_SRA	=	4'h9,
	A_LUI	= 	4'hA	
  } alu_op_e;
  alu_op_e alu_op;

  assign alu_op = alu_op_i;
  assign sltu_tmp = {31'b0,L_u} ;
  assign slt_tmp  = {31'b0,L_s} ;
  assign br_not_used = E_u | E_s | G_u  | G_s ;

  //  -------------------------------------------------------------------------------------------

  sltu_32b sltu_32b_alu (  
	.L (L_u), .E( E_u), .G (G_u),
    .a0  (operand_a_i[0]),  .a1  (operand_a_i[1]),  .a2  (operand_a_i[2]),    .a3  (operand_a_i[3]),	.a4  (operand_a_i[4]),	.a5  (operand_a_i[5]),
    .a6  (operand_a_i[6]),  .a7  (operand_a_i[7]),  .a8  (operand_a_i[8]),    .a9  (operand_a_i[9]),	.a10 (operand_a_i[10]),	.a11 (operand_a_i[11]),
	.a12 (operand_a_i[12]),	.a13 (operand_a_i[13]),	.a14 (operand_a_i[14]),   .a15 (operand_a_i[15]),	.a16 (operand_a_i[16]),	.a17 (operand_a_i[17]),
    .a18 (operand_a_i[18]),	.a19 (operand_a_i[19]), .a20 (operand_a_i[20]),   .a21 (operand_a_i[21]),   .a22 (operand_a_i[22]), .a23 (operand_a_i[23]),
    .a24 (operand_a_i[24]), .a25 (operand_a_i[25]), .a26 (operand_a_i[26]),   .a27 (operand_a_i[27]),   .a28 (operand_a_i[28]), .a29 (operand_a_i[29]),
	.a30 (operand_a_i[30]), .a31 (operand_a_i[31]),
    .b0  (operand_b_i[0]),  .b1  (operand_b_i[1]),  .b2  (operand_b_i[2]),    .b3  (operand_b_i[3]),	.b4  (operand_b_i[4]),	.b5  (operand_b_i[5]),
    .b6  (operand_b_i[6]),  .b7  (operand_b_i[7]),  .b8  (operand_b_i[8]),    .b9  (operand_b_i[9]),	.b10 (operand_b_i[10]),	.b11 (operand_b_i[11]),
	.b12 (operand_b_i[12]),	.b13 (operand_b_i[13]),	.b14 (operand_b_i[14]),   .b15 (operand_b_i[15]),	.b16 (operand_b_i[16]),	.b17 (operand_b_i[17]),
    .b18 (operand_b_i[18]),	.b19 (operand_b_i[19]), .b20 (operand_b_i[20]),   .b21 (operand_b_i[21]),   .b22 (operand_b_i[22]), .b23 (operand_b_i[23]),
    .b24 (operand_b_i[24]), .b25 (operand_b_i[25]), .b26 (operand_b_i[26]),   .b27 (operand_b_i[27]),   .b28 (operand_b_i[28]), .b29 (operand_b_i[29]),
	.b30 (operand_b_i[30]), .b31 (operand_b_i[31])
);
    	
  //  -------------------------------------------------------------------------------------------

  slt_32b slt_32b_alu (  
	.L (L_s), .E( E_s), .G (G_s),
    .a0  (operand_a_i[0]),  .a1  (operand_a_i[1]),  .a2  (operand_a_i[2]),    .a3  (operand_a_i[3]),	.a4  (operand_a_i[4]),	.a5  (operand_a_i[5]),
    .a6  (operand_a_i[6]),  .a7  (operand_a_i[7]),  .a8  (operand_a_i[8]),    .a9  (operand_a_i[9]),	.a10 (operand_a_i[10]),	.a11 (operand_a_i[11]),
	.a12 (operand_a_i[12]),	.a13 (operand_a_i[13]),	.a14 (operand_a_i[14]),   .a15 (operand_a_i[15]),	.a16 (operand_a_i[16]),	.a17 (operand_a_i[17]),
    .a18 (operand_a_i[18]),	.a19 (operand_a_i[19]), .a20 (operand_a_i[20]),   .a21 (operand_a_i[21]),   .a22 (operand_a_i[22]), .a23 (operand_a_i[23]),
    .a24 (operand_a_i[24]), .a25 (operand_a_i[25]), .a26 (operand_a_i[26]),   .a27 (operand_a_i[27]),   .a28 (operand_a_i[28]), .a29 (operand_a_i[29]),
	.a30 (operand_a_i[30]), .a31 (operand_a_i[31]),
    .b0  (operand_b_i[0]),  .b1  (operand_b_i[1]),  .b2  (operand_b_i[2]),    .b3  (operand_b_i[3]),	.b4  (operand_b_i[4]),	.b5  (operand_b_i[5]),
    .b6  (operand_b_i[6]),  .b7  (operand_b_i[7]),  .b8  (operand_b_i[8]),    .b9  (operand_b_i[9]),	.b10 (operand_b_i[10]),	.b11 (operand_b_i[11]),
	.b12 (operand_b_i[12]),	.b13 (operand_b_i[13]),	.b14 (operand_b_i[14]),   .b15 (operand_b_i[15]),	.b16 (operand_b_i[16]),	.b17 (operand_b_i[17]),
    .b18 (operand_b_i[18]),	.b19 (operand_b_i[19]), .b20 (operand_b_i[20]),   .b21 (operand_b_i[21]),   .b22 (operand_b_i[22]), .b23 (operand_b_i[23]),
    .b24 (operand_b_i[24]), .b25 (operand_b_i[25]), .b26 (operand_b_i[26]),   .b27 (operand_b_i[27]),   .b28 (operand_b_i[28]), .b29 (operand_b_i[29]),
	.b30 (operand_b_i[30]), .b31 (operand_b_i[31])
);

  // ALU control -------------------------------------------------------------------------------------------

  always_comb begin: proc_alu
	case (alu_op)	
	A_ADD:   alu_data_o = operand_a_i + operand_b_i;

	A_SUB:   alu_data_o = operand_a_i + (~ operand_b_i + 32'd1); 

	A_SLT:   alu_data_o = slt_tmp; 

	A_SLTU:  alu_data_o = sltu_tmp; 

	A_XOR:   alu_data_o = operand_a_i ^ operand_b_i; 

	A_OR:    alu_data_o = operand_a_i | operand_b_i; 

	A_AND:   alu_data_o = operand_a_i & operand_b_i;

	A_SLL:   alu_data_o = operand_a_i << operand_b_i[4:0];

	A_SRL:   alu_data_o = srl_tmp;

	A_SRA:  begin
			case(operand_b_i[4:0])
			5'd0 : alu_data_o = operand_a_i; 
			5'd1 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'h80000000 );
			5'd2 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hC0000000 );
			5'd3 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hE0000000 );
			5'd4 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hF0000000 );
			5'd5 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hF8000000 );
			5'd6 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFC000000 ); 
			5'd7 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFE000000 );
			5'd8 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFF000000 );
			5'd9 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFF800000 );
			
			5'd10 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFC00000 );
			5'd11 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFE00000 );
			5'd12 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFF00000 );
			5'd13 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFF80000 );
			5'd14 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFC0000 );
			5'd15 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFE0000 );
			5'd16 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFF0000 );
			5'd17 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFF8000 );
			5'd18 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFC000 );
			5'd19 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFE000 );
			5'd20 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFF000 );
			
			5'd21 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFF800 );
			5'd22 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFC00 );
			5'd23 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFE00 );
			5'd24 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFF00 );
			5'd25 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFF80 );
			5'd26 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFFC0 );
			5'd27 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFFE0 );
			5'd28 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFFF0 );
			5'd29 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFFF8 );
			5'd30 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFFFC );			
			5'd31 : alu_data_o = (operand_a_i[31] == 0)? srl_tmp: (srl_tmp | 32'hFFFFFFFE );
			default: alu_data_o =  32'b0;
			endcase			
			end
	A_LUI:	 alu_data_o = operand_b_i; 	       
	default: alu_data_o = 32'd0;
	endcase
  end
  assign srl_tmp = operand_a_i >> operand_b_i[4:0];

endmodule 
