/* verilator lint_off UNUSED */
/* verilator lint_off LATCH */

module fpu_pre_norm (
  input  logic clk_i,
  input  logic [31:0] op_a_i, op_b_i,
  input  logic [1:0] fpu_op_i,
  input  logic alu_fpu_en_i,
  output logic [32:0] pre_a_o,
  output logic [32:0] pre_b_o,
  output logic [2:0]  exception_o,
  output logic [31:0] exception_value
);
 
  logic a_nan, b_nan, a_zero, b_zero, a_inf, b_inf;
  logic [7:0] state ;
  assign a_nan = (op_a_i[30:23] == 255 && op_a_i[22:0] != 0)? 1: 0; // A is Not a number
  assign b_nan = (op_b_i[30:23] == 255 && op_b_i[22:0] != 0)? 1: 0; // B is Not a number
  
  assign b_zero = ((op_b_i[30:23] == 0) && (op_b_i[22:0] == 0))? 1 :0; // B is zero
  assign a_zero = ((op_a_i[30:23] == 0) && (op_a_i[22:0] == 0))? 1 :0; // A is zero

  assign a_inf = (op_a_i[30:23] == 255 && op_a_i[22:0] == 0)? 1: 0; // A is infinite
  assign b_inf = (op_b_i[30:23] == 255 && op_b_i[22:0] == 0)? 1: 0; // B is infinite


  assign state = {fpu_op_i, a_nan, b_nan, a_zero, b_zero, a_inf, b_inf};

  always_comb begin
    case (state)
      //If a is NaN or b is zero return a for add and sub
      8'b01100100, 8'b00100100, 8'b00000100: begin 
        exception_o = 3'h001;
        pre_a_o = 0;
        pre_b_o = 0;
        exception_value = op_a_i;
      end
      //If b is NaN or a is zero return b for add and sub
      8'b01011000, 8'b00011000, 8'b00001000: begin 
        exception_o = 3'b010;
        pre_b_o = 0;
        pre_a_o = 0;
        exception_value = op_b_i;
      end
      //if a or b is inf return inf
      8'b01000010, 8'b01000001, 8'b00000010, 8'b00000001 : begin 
        exception_o = 3'b011;
        pre_b_o = 0;
        pre_a_o = 0;
        exception_value = {(pre_b_o[31]^pre_a_o[31]),31'h3FFFFFFF};
      end
      8'b01000000, 8'b01001000: begin // SUB
          exception_o = 3'b000;
        pre_a_o = {op_a_i[31], op_a_i[30:23] ,  1'b1,  op_a_i[22:0] };
        pre_b_o = {~op_b_i[31], op_b_i[30:23] ,  1'b1,  op_b_i[22:0] };
      end
      8'b00000000: begin // ADD
          exception_o = 3'b000;
        pre_a_o = {op_a_i[31], op_a_i[30:23] ,  1'b1,  op_a_i[22:0] };
        pre_b_o = {op_b_i[31], op_b_i[30:23] ,  1'b1,  op_b_i[22:0] };
      end
      default: begin // ERROR
        exception_o = 3'b100;
        pre_a_o = 0;
        pre_b_o = 0;
      end

    endcase
  end
endmodule


