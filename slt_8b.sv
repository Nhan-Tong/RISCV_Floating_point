module slt_8b (
  input logic [7:0] A_i,
  input logic [7:0] B_i,
  output logic      L_o, // A is less than B 
  output logic      G_o, // A is equal B
  output logic      E_o  // A is Greater than B
);

  Logic [3:0] L, G, E ;

  assign E_o = E[0]&E[1]&E[2]&E[3];
  assign G_o = G[3]|(e[3]&G[2])|(e[3]&e[2]&G[1])|(e[3]&e[2]&e[1]&G[0]);
  assign L_o = l[3]|(e[3]&l[2])|(e[3]&e[2]&l[1])|(e[3]&e[2]&e[1]&l[0]);

  slt_2b slt1(G[0],E[0],L[0],A_i[0],A_i[1],B_i[0],B_i[1]);
  slt_2b slt2(G[1],E[1],L[1],A_i[2],A_i[3],B_i[2],B_i[3]);
  slt_2b slt3(G[2],E[2],L[2],A_i[4],A_i[5],B_i[4],B_i[5]);
  slt_2b slt4(G[3],E[3],L[3],A_i[6],A_i[7],B_i[6],B_i[7]);
endmodule
