module slt_2b ( G,E,L,a1,a0,b1,b0);
input logic  a1,a0,b1,b0;
output logic  G,E,L;
assign G = (~a1& b1)|(~a1 & a0 & ~b0)|(a0 & b1 & ~b0);
assign E = (a1 ~^ b1)&(a0 ~^ b0);
assign L = (a1& ~b1)|((a1) & ~a0 & b0)|(~a0 & ~b1 & b0);
endmodule 
