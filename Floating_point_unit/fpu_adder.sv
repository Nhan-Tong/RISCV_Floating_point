module fpu_adder(
  input logic [31:0] a, b,
  output logic [31:0] out
);
  logic [31:0] out;
	logic        a_sign;
	logic [7:0]  a_exp;
	logic [23:0] a_man;
	logic        b_sign;
	logic [7:0]  b_exp;
	logic [23:0] b_man;

  logic        o_sign;
  logic [7:0]  o_exp;
  logic [24:0] o_man;

  logic [7:0]  diff;
  logic [23:0] tmp_mantissa;
  logic [7:0]  tmp_exponent;


  logic [7:0]  i_e_norm;
  logic [24:0] i_m_norm;
  logic [7:0]  o_e_norm;
  logic [24:0] o_m_norm;

  addition_normaliser norm1
  (
    .in_e(i_e_norm),
    .in_m(i_m_norm),
    .out_e(o_e_norm),
    .out_m(o_m_norm)
  );

  assign out[31] = o_sign;
  assign out[30:23] = o_exp;
  assign out[22:0] = o_man[22:0];

  always_comb begin
    // pre-mornalization --------------------------------------------------------------------------------------------------
		a_sign = a[31];
		if(a[30:23] == 0) begin // exp ~= -128, A ~= 0
			a_exp = 8'b00000001; 
			a_man = {1'b0, a[22:0]};
		end else begin
			a_exp = a[30:23];
			a_man = {1'b1, a[22:0]};
		end
		b_sign = b[31]; 
		if(b[30:23] == 0) begin // exp ~= -128, B ~= 0
			b_exp = 8'b00000001;
			b_man = {1'b0, b[22:0]};
		end else begin
			b_exp = b[30:23];
			b_man = {1'b1, b[22:0]};
		end
    // Calculation --------------------------------------------------------------------------------------------------
    if (a_exp == b_exp) begin // Equal exponents
      o_exp = a_exp;
      if (a_sign == b_sign) begin // Equal signs = normal add
        o_man = a_man + b_man;
        o_man[24] = 1;
        o_sign = a_sign;

      end else begin // Opposite signs = subtract
        if(a_man > b_man) begin
          o_man = a_man +(~ b_man);
          o_sign = a_sign;
        end else begin
          o_man = b_man +(~a_man);
          o_sign = b_sign;
        end
      end
    end else begin //Unequal exponents
      if (a_exp > b_exp) begin // A > B
        o_exp = a_exp;
        o_sign = a_sign;
				diff = a_exp + (~b_exp);
        tmp_mantissa = b_man >> diff;

        if (a_sign == b_sign) 
          o_man = a_man + tmp_mantissa;
        else
          o_man = a_man +(~ tmp_mantissa);

      end else if (a_exp < b_exp) begin // B > A
        o_exp = b_exp;
        o_sign = b_sign;
        diff = b_exp +(~ a_exp);
        tmp_mantissa = a_man >> diff;

        if (a_sign == b_sign)
          o_man = b_man + tmp_mantissa;
        else
		      o_man = b_man +(~ tmp_mantissa);

      end
    end
    
    // Post-normalization--------------------------------------------------------------------------------------------
    if(o_man[24] == 1) begin
      o_exp = o_exp + 1;
      o_man = o_man >> 1;
    end else if((o_man[23] != 1) && (o_exp != 0)) begin
      i_e_norm = o_exp;
      i_m_norm = o_man;
      o_exp = o_e_norm;
      o_man = o_m_norm;
    end
  end // end always
endmodule