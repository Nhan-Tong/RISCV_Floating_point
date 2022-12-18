module sltu_2b (G,E,L,a1,a0,b1,b0);
    input logic a1,a0,b1,b0 ;
	output logic  G,E,L;

	assign L = (~a1& b1) | ((a1 ~^ b1)&(~a0 & b0)); // A  less than B 
	assign E = (a1 ~^ b1)&(a0 ~^ b0);                   // A  equal B 
	assign G = (a1& ~b1) | ((a1 ~^ b1)&(a0 & ~b0)); // A greater than B

endmodule 
