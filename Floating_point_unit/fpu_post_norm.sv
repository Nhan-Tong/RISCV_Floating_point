/* verilator lint_off UNUSED */


module fpu_post_norm (
    input logic [33:0] add_i,
    input logic [3:0] exception_i,
    output logic [31:0] norm_o
);

  logic [7:0] in_e;
  logic [24:0] in_m;
  logic [7:0] out_e;
  logic [24:0] out_m;

  logic [7:0] n_exp;
  logic [24:0] n_man;
  logic n_sign;
  
  assign in_e = add_i[32:25];
  assign in_m = add_i[24:0];

  assign norm_o = {add_i[33],out_e,out_m[22:0]};

    always_comb begin
      out_e = 0;
      out_m = 0;
    if(exception_i == 0) begin
    if(add_i[24] == 1) begin
      out_m  = in_m >> 1;
      out_e  = in_e + 1;
    end else if((add_i[23] != 1) && (add_i[32:25] != 0)) begin
      if (in_m[23:3] == 21'b000000000000000000001) begin
        out_e = in_e - 20;
        out_m = in_m << 20;
      end else if (in_m[23:4] == 20'b00000000000000000001) begin
        out_e = in_e - 19;
        out_m = in_m << 19;
      end else if (in_m[23:5] == 19'b0000000000000000001) begin
        out_e = in_e - 18;
        out_m = in_m << 18;
      end else if (in_m[23:6] == 18'b000000000000000001) begin
        out_e = in_e - 17;
        out_m = in_m << 17;
      end else if (in_m[23:7] == 17'b00000000000000001) begin
        out_e = in_e - 16;
        out_m = in_m << 16;
      end else if (in_m[23:8] == 16'b0000000000000001) begin
        out_e = in_e - 15;
        out_m = in_m << 15;
      end else if (in_m[23:9] == 15'b000000000000001) begin
        out_e = in_e - 14;
        out_m = in_m << 14;
      end else if (in_m[23:10] == 14'b00000000000001) begin
        out_e = in_e - 13;
        out_m = in_m << 13;
      end else if (in_m[23:11] == 13'b0000000000001) begin
        out_e = in_e - 12;
        out_m = in_m << 12;
      end else if (in_m[23:12] == 12'b000000000001) begin
        out_e = in_e - 11;
        out_m = in_m << 11;
      end else if (in_m[23:13] == 11'b00000000001) begin
        out_e = in_e - 10;
        out_m = in_m << 10;
      end else if (in_m[23:14] == 10'b0000000001) begin
        out_e = in_e - 9;
        out_m = in_m << 9;
      end else if (in_m[23:15] == 9'b000000001) begin
        out_e = in_e - 8;
        out_m = in_m << 8;
      end else if (in_m[23:16] == 8'b00000001) begin
        out_e = in_e - 7;
        out_m = in_m << 7;
      end else if (in_m[23:17] == 7'b0000001) begin
        out_e = in_e - 6;
        out_m = in_m << 6;
      end else if (in_m[23:18] == 6'b000001) begin
        out_e = in_e - 5;
        out_m = in_m << 5;
      end else if (in_m[23:19] == 5'b00001) begin
        out_e = in_e - 4;
        out_m = in_m << 4;
      end else if (in_m[23:20] == 4'b0001) begin
        out_e = in_e - 3;
        out_m = in_m << 3;
      end else if (in_m[23:21] == 3'b001) begin
        out_e = in_e - 2;
        out_m = in_m << 2;
      end else if (in_m[23:22] == 2'b01) begin
        out_e = in_e - 1;
        out_m = in_m << 1;
      end else begin
        out_e = in_e;
        out_m = in_m;
      end
    end
  end
  end
endmodule









