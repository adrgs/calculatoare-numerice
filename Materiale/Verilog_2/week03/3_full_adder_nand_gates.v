module NANDgate(A,B,C);

 input A;
 input B;
 output C;
 reg C;

 always @ (A or B)
 begin
	C <= ~(A & B);
 end

endmodule

module testbench;

 reg A_t, B_t, C_in;
 output S, C_out;
 wire w1,w2,w3,w4,w5,w6,w7;
 
 NANDgate my_nand_1(A_t, B_t, w1);
 NANDgate my_nand_2(A_t, w1, w2);
 NANDgate my_nand_3(w1, B_t, w3);
 NANDgate my_nand_4(w2, w3, w4);
 NANDgate my_nand_5(C_in, w4, w5);
 NANDgate my_nand_6(C_in, w5, w6);
 NANDgate my_nand_7(w5, w4, w7);
 NANDgate my_nand_8(w5, w1, C_out);
 NANDgate my_nand_9(w6, w7, S);


 initial 
 begin 

 A_t=0;
 B_t=0;
 C_in=0;
 #1 $display("S=%b,C=%b\n",S,C_out);

 A_t=1;
 B_t=0;
 C_in=0;
 #1 $display("S=%b,C=%b\n",S,C_out);

 A_t=0;
 B_t=1;
 C_in=0;
 #1 $display("S=%b,C=%b\n",S,C_out);

 A_t=1;
 B_t=1;
 C_in=0;
 #1 $display("S=%b,C=%b\n",S,C_out);

 end


endmodule


