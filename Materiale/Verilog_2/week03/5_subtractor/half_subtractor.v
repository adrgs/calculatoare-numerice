module XOR(A,B,S);
	input A, B;
	output reg S;

        always @ (A or B)
	begin
		S = A^B;
	end
endmodule

module AND(A,B,S);

	input A, B;
	output reg S;

	always @ (A or B)
	begin
		S = A & ~B;
	end
endmodule

module half_adder;

	reg A, B;
	output S, C;
	

	XOR myXOR(A,B,S);
	AND myAND(A,B,C);

	initial
	begin	
		A = 0;
		B = 0;
		#1 $display("S=%b, C=%b\n",S,C);

		A = 0;
		B = 1;
		#1 $display("S=%b, C=%b\n",S,C);

		A = 1;
		B = 0;
		#1 $display("S=%b, C=%b\n",S,C);

		A = 1;
		B = 1;
		#1 $display("S=%b, C=%b\n",S,C);
	end
endmodule
	


