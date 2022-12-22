module fpu_add (
    input logic [32:0] pre_a_i,
    input logic [32:0] pre_b_i,
    input logic [2:0]  exception_i,
    output logic [33:0] add_o
    //output logic norm_en
);
  // pre_a,b = [[32]sign__[31:24]exp__1'b1__[22:0]frac]
  logic a_sign, b_sign;
  logic [7:0] a_exp , b_exp;
  logic [23:0] a_man, b_man; // mantissa
  
  logic [7:0] diff;
  logic [23:0] tmp_mantissa;
  //logic [7:0] tmp_exponent;

  logic o_sign;
  logic [7:0] o_exp;
  logic [24:0] o_man;

  assign a_sign = pre_a_i[32];
  assign a_exp  = (pre_a_i[31:24] != 0 )? pre_a_i[31:24]: 8'b00000001 ;
  assign a_man  = pre_a_i[23:0];
  
  assign b_sign = pre_b_i[32];
  assign b_exp  = (pre_b_i[31:24] != 0 )? pre_b_i[31:24]: 8'b00000001 ;
  assign b_man  = pre_b_i[23:0];

  assign add_o = {o_sign, o_exp, o_man};
  
  always_comb begin 
    if(exception_i == 0) begin
        if(a_exp == b_exp) begin // Equal exponents
        o_exp = a_exp;
        if( a_sign == b_sign) begin
            o_man = a_man + b_man;
            o_sign = a_sign;
        end else begin// sub
            if(a_man > b_man) begin
            o_man = a_man + (~b_man + 1);
            o_sign = a_sign;
            end else begin
            o_man = b_man + (~a_man + 1);
            o_sign = b_sign;
            end
        end 
        end else if(a_exp > b_exp) begin // unequal exponents
        o_exp = a_exp;
        o_sign = a_sign;
        diff   = a_exponent + (~b_exponent +1);
        tmp_mantissa = b_man >> diff;
        if(a_sign == b_sign) 
            o_man = a_man + tmp_mantissa;
        else
            o_man = a_man + (~tmp_mantissa +1);
        end else if (a_exp < b_exp) begin
        o_exp = b_exp;
        o_sign = b_sign;
        diff   = b_exponent + (~a_exponent +1);
        tmp_mantissa = a_man >> diff;
        if(a_sign == b_sign) 
            o_man = b_man + tmp_mantissa;
        else
            o_man = b_man + (~tmp_mantissa +1);
        end
    end
  end


endmodule

