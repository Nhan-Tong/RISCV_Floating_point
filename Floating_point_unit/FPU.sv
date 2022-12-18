
//IEEE 754 Single Precision ALU
module fpu(
	input logic clk_i,
	input logic [31:0] op_a_i, op_b_i,
	input logic [1:0] opcode,
	output logic [31:0] fpu_o
  );
	logic [31:0] fpu_o;
	logic [7:0] a_exponent;
	logic [23:0] a_mantissa;
	logic [7:0] b_exponent;
	logic [23:0] b_mantissa;

	logic        o_sign;
	logic [7:0]  o_exponent;
	logic [24:0] o_mantissa;


	logic [31:0] adder_a_in; 
	logic [31:0] adder_b_in; 
	logic [31:0] adder_out;  


	assign fpu_o[31] = o_sign;
	assign fpu_o[30:23] = o_exponent;
	assign fpu_o[22:0] = o_mantissa[22:0];

	assign a_sign = op_a_i[31];
	assign a_exponent[7:0] = op_a_i[30:23];
	assign a_mantissa[23:0] = {1'b1, op_a_i[22:0]};

	assign b_sign = op_b_i[31];
	assign b_exponent[7:0] = op_b_i[30:23];
	assign b_mantissa[23:0] = {1'b1, op_b_i[22:0]};

	assign ADD = !opcode[1] & !opcode[0];
	assign SUB = !opcode[1] & opcode[0];


	fpu_adder A1
	(
		.a(adder_a_in),
		.b(adder_b_in),
		.out(adder_out)
	);

	always_ff @(posedge clk_i) begin
		if (ADD) begin
			//If a is NaN or b is zero return a
			if ((a_exponent == 255 && a_mantissa != 0) || (b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign;
				o_exponent = a_exponent;
				o_mantissa = a_mantissa;
			//If b is NaN or a is zero return b
			end else if ((b_exponent == 255 && b_mantissa != 0) || (a_exponent == 0) && (a_mantissa == 0)) begin
				o_sign = b_sign;
				o_exponent = b_exponent;
				o_mantissa = b_mantissa;
			//if a or b is inf return inf
			end else if ((a_exponent == 255) || (b_exponent == 255)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin // Passed all corner cases
				adder_a_in = A;
				adder_b_in = B;
				o_sign = adder_out[31];
				o_exponent = adder_out[30:23];
				o_mantissa = adder_out[22:0];
			end
		end else if (SUB) begin
			//If a is NaN or b is zero return a
			if ((a_exponent == 255 && a_mantissa != 0) || (b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign;
				o_exponent = a_exponent;
				o_mantissa = a_mantissa;
			//If b is NaN or a is zero return b
			end else if ((b_exponent == 255 && b_mantissa != 0) || (a_exponent == 0) && (a_mantissa == 0)) begin
				o_sign = b_sign;
				o_exponent = b_exponent;
				o_mantissa = b_mantissa;
			//if a or b is inf return inf
			end else if ((a_exponent == 255) || (b_exponent == 255)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin // Passed all corner cases
				adder_a_in = A;
				adder_b_in = {~B[31], B[30:0]};
				o_sign = adder_out[31];
				o_exponent = adder_out[30:23];
				o_mantissa = adder_out[22:0];
			end
		end 
	end
endmodule





