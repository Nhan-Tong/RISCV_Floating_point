module sltu_32b (L,E,G,a0,a1,a2,a3,a4,a5,a6,a7,
				a8,a9,a10,a11,a12,a13,a14,a15,
				a16,a17,a18,a19,a20,a21,a22,a23,
				a24,a25,a26,a27,a28,a29,a30,a31,
				b0,b1,b2,b3,b4,b5,b6,b7,
				b8,b9,b10,b11,b12,b13,b14,b15,
			    b16,b17,b18,b19,b20,b21,b22,b23,
     		    b24,b25,b26,b27,b28,b29,b30,b31	);
// khai báo ngõ vào dữ liệu 2 số A và B 32 bit
     		    	
input logic     a0,a1,a2,a3,a4,a5,a6,a7,
				a8,a9,a10,a11,a12,a13,a14,a15,
				a16,a17,a18,a19,a20,a21,a22,a23,
				a24,a25,a26,a27,a28,a29,a30,a31,
				b0,b1,b2,b3,b4,b5,b6,b7,
				b8,b9,b10,b11,b12,b13,b14,b15,
			    b16,b17,b18,b19,b20,b21,b22,b23,
			    b24,b25,b26,b27,b28,b29,b30,b31;
// ngõ ra so sánh 
output logic L,E,G;
// logic 

logic [16:1] g,e,l;
// tạo 16 khối stlu_2b
sltu_2b sltu_2b_s1   (g[16],e[16],l[16],a31,a30,b31,b30);
sltu_2b sltu_2b_s2   (g[15],e[15],l[15],a29,a28,b29,b28);
sltu_2b sltu_2b_s3   (g[14],e[14],l[14],a27,a26,b27,b26);
sltu_2b sltu_2b_s4   (g[13],e[13],l[13],a25,a24,b25,b24);
sltu_2b sltu_2b_s5   (g[12],e[12],l[12],a23,a22,b23,b22);
sltu_2b sltu_2b_s6   (g[11],e[11],l[11],a21,a20,b21,b20);
sltu_2b sltu_2b_s7   (g[10],e[10],l[10],a19,a18,b19,b18);
sltu_2b sltu_2b_s8   (g[9],e[9],l[9],a17,a16,b17,b16);
sltu_2b sltu_2b_s9   (g[8],e[8],l[8],a15,a14,b15,b14);
sltu_2b sltu_2b_s10  (g[7],e[7],l[7],a13,a12,b13,b12);
sltu_2b sltu_2b_s11  (g[6],e[6],l[6],a11,a10,b11,b10);
sltu_2b sltu_2b_s12  (g[5],e[5],l[5],a9,a8,b9,b8);
sltu_2b sltu_2b_s13  (g[4],e[4],l[4],a7,a6,b7,b6);
sltu_2b sltu_2b_s14  (g[3],e[3],l[3],a5,a4,b5,b4);
sltu_2b sltu_2b_s15  (g[2],e[2],l[2],a3,a2,b3,b2);
sltu_2b sltu_2b_s16  (g[1],e[1],l[1],a1,a0,b1,b0);

assign G = g[16]|
          (e[16]&g[15])|
          (e[16]&e[15]&g[14])|
          (e[16]&e[15]&e[14]&g[13])|
          (e[16]&e[15]&e[14]&e[13]&g[12])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&g[11])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&g[10])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&g[9])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&g[8])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&g[7])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&g[6])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&g[5])|   
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&g[4])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&e[4]&g[3])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&e[4]&e[3]&g[2])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&e[4]&e[3]&e[2]&g[1]);

assign E = e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&e[4]&e[3]&e[2]&e[1];

assign L = l[16]|
          (e[16]&l[15])|
          (e[16]&e[15]&l[14])|
          (e[16]&e[15]&e[14]&l[13])|
          (e[16]&e[15]&e[14]&e[13]&l[12])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&l[11])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&l[10])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&l[9])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&l[8])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&l[7])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&l[6])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&l[5])|   
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&l[4])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&e[4]&l[3])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&e[4]&e[3]&l[2])|
          (e[16]&e[15]&e[14]&e[13]&e[12]&e[11]&e[10]&e[9]&e[8]&e[7]&e[6]&e[5]&e[4]&e[3]&e[2]&l[1]);


endmodule 
