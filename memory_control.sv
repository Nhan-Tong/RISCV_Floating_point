module memory_control (
	input  logic        clk_i,
	input  logic        rst_ni,
	input  logic [31:0] st_data_i,
	input  logic [11:0] addr_i,
	input  logic        lsc_wren_i,
	input  logic  [3:0] ls_op_i,
	output logic [31:0] mem_data_o,
	input  logic [31:0] sw_i,
	output logic [31:0] io_ledr_o,io_ledg_o,io_hex0_o,io_hex1_o,io_hex2_o,
	                    io_hex3_o,io_hex4_o,io_hex5_o,io_hex6_o,io_hex7_o,
	output logic [31:0] io_lcd_o	
);

	typedef enum logic[3:0] {
		SB  = 4'b0001,
		SH  = 4'b0010,
		SW  = 4'b0011,
		LB  = 4'b0100,
		LH  = 4'b0101,
		LW  = 4'b0110,
		LBU = 4'b0111,
		LHU = 4'b1000
	}ls_instr;
	ls_instr ls_instruction;

	logic [31:0] wdata_tmp, rdata_tmp;
	logic [11:0] omem_addr,dmem_addr;
	logic [31:0] dmem_data_i, dmem_data_o, imem_data;
	logic [31:0] omem_data [0:10];
	logic [3:0]  addr_sel;
	logic        omem_en, dmem_en;

	assign addr_sel = addr_i[11:8];
	assign ls_instruction = ls_op_i;

	// store instruction -------------------------------------------------------------------------------------------
	always_comb begin : store_mux
		if(lsc_wren_i) begin
			case (ls_instruction) 
			SW:      wdata_tmp = st_data_i;
			SB:	     wdata_tmp = (st_data_i & 32'h000000ff) | (rdata_tmp & 32'hffffff00);
			SH:	     wdata_tmp = (st_data_i & 32'h0000ffff) | (rdata_tmp & 32'hffff0000);
			default: wdata_tmp = st_data_i;
			endcase
		end
		else wdata_tmp = st_data_i;
	end

	// memory selection -------------------------------------------------------------------------------------------
	always_comb begin : addrsel
		case(addr_sel) // data mem
		4'd0,4'd1,4'd2,4'd3 :begin
			// omem control 
			omem_en     = 0;
			omem_addr   = 0; 
			// dmem control 
			dmem_en     = lsc_wren_i;
			dmem_addr   = addr_i[11:0];
			dmem_data_i = wdata_tmp;
			end 
		4'd4:begin // output periph
			// omem control 
			omem_en     = lsc_wren_i; 
			omem_addr   = addr_i[11:0]; 
			// dmem control
			dmem_addr   = 0;
			dmem_en     = 0; 
			dmem_data_i = 0;
			end	
		default:begin
			omem_en     = 0; 
			omem_addr   = 0; 
			dmem_addr   = 0;
			dmem_en     = 0;
			dmem_data_i = 0;
			end
			endcase
	end
  // input peripheral mem control -------------------------------------------------------------------------------

	assign imem_data = (addr_i == 12'h500)? sw_i : 32'h0;

  // data mem control -------------------------------------------------------------------------------------------

	data_mem mem1(
    .paddr_i    (dmem_addr  ),
    .penable_i  (dmem_en    ),
    .psel_i     (1'b1       ),
    .pwrite_i   (1'b1       ),
    .pwdata_i   (dmem_data_i),
    .pstrb_i    (4'b1111    ),
    .prdata_o   (dmem_data_o),
    .clk_i      (clk_i      ),
    .rst_ni     (rst_ni     )
    );

  // output peripheral control ------------------------------------------------------------------------------------

  always_ff @(posedge clk_i) begin
    if(omem_en) begin
    case(omem_addr[11:0])
      12'h400: omem_data[0]  <= wdata_tmp; // io_hex0_o
      12'h410: omem_data[1]  <= wdata_tmp; // io_hex1_o
      12'h420: omem_data[2]  <= wdata_tmp; // io_hex2_o
      12'h430: omem_data[3]  <= wdata_tmp; // io_hex3_o
      12'h440: omem_data[4]  <= wdata_tmp; // io_hex4_o
      12'h450: omem_data[5]  <= wdata_tmp; // io_hex5_o
      12'h460: omem_data[6]  <= wdata_tmp; // io_hex6_o
      12'h470: omem_data[7]  <= wdata_tmp; // io_hex7_o
      12'h480: omem_data[8]  <= wdata_tmp; // io_ledr_o
      12'h490: omem_data[9]  <= wdata_tmp; // io_ledg_o
      12'h4A0: omem_data[10] <= wdata_tmp; // io_lcd_o
      default:begin 
               omem_data[omem_addr[7:4]] <= 32'b0;
      end
    endcase
  end
  end
  assign {io_hex0_o,io_hex1_o,io_hex2_o,io_hex3_o,io_hex4_o,io_hex5_o,io_hex6_o,io_hex7_o,io_ledr_o,io_ledg_o,io_lcd_o} =
  {omem_data[0],omem_data[1],omem_data[2],omem_data[3],omem_data[4],omem_data[5],omem_data[6],omem_data[7],omem_data[8],omem_data[9],omem_data[10]};
  // data out control -------------------------------------------------------------------------------------------

	always_comb begin : READDATA
		case(addr_sel)
		4'd0,4'd1,4'd2,4'd3:begin // dmem out
			rdata_tmp = dmem_data_o;
			end 
		4'd4:begin // omem out 
			rdata_tmp = omem_data[omem_addr[7:4]];
			end	
		4'd5: begin // imem out
			rdata_tmp = imem_data;
		end
		default:begin
			rdata_tmp = 0;
			end
			endcase
	end

  // load instruction control ------------------------------------------------------------------------------------

	always_comb begin : load_mux
		if(!lsc_wren_i) begin
			case(ls_instruction)
			LW: 	mem_data_o =  rdata_tmp;
			LBU: 	mem_data_o =  rdata_tmp  & 32'h000000ff;	
			LHU:	mem_data_o =  rdata_tmp & 32'h0000ffff;	
			LB:		mem_data_o = (rdata_tmp[7] ==1)? (rdata_tmp & 32'h000000ff | 32'hffffff00):(rdata_tmp & 32'h000000ff);
			LH:		mem_data_o = (rdata_tmp[15] ==1)? (rdata_tmp & 32'h0000ffff | 32'hffff0000):(rdata_tmp & 32'h0000ffff);
			default:mem_data_o =  rdata_tmp ; 
			endcase
		end
		else 	    mem_data_o = rdata_tmp;
	end
endmodule

