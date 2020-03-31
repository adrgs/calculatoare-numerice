// Module pentru porti logice, toate realizate prin porti NAND
module NAND(in1, in2, out);
input in1, in2;
output out;

assign out = ~(in1 & in2);
endmodule

module NOT(in, out);
input in;
output out;
NAND NAND1(in, in, out);
endmodule

module AND(in1, in2, out);
input in1, in2;
output out;
wire w;

NAND NAND1(in1, in2, w);
NAND NAND2(w, w, out);
endmodule

module OR(in1, in2, out);
input in1, in2;
output out;
wire w1, w2;

NAND NAND1(in1, in1, w1);
NAND NAND2(in2, in2, w2);
NAND NAND3(w1, w2, out);
endmodule

module XOR(in1, in2, out);
input in1, in2;
output out;
wire w1, w2, w3;

NAND NAND1(in1, in2, w1);
NAND NAND2(in1, w1, w2);
NAND NAND3(in2, w1, w3);
NAND NAND4(w2, w3, out);
endmodule

// ( (A and B) or (not C) ) xor ( (not B) or C )
module SubpunctulA(A, B, C, out);
input A, B, C;
output out;
wire w1, w2, w3, w4, w5;

AND AND1(A, B, w1);
NOT NOT1(C, w2);
OR OR1(w1, w2, w3);
NOT NOT2(B, w4);
OR OR2(C, w4, w5);
XOR XOR1(w3, w5, out);
endmodule

// ( ( A or B or C) and ( A xor C) ) or (not B)
module SubpunctulB(A, B, C, out);
input A, B, C;
output out;
wire w1, w2, w3, w4, w5;

OR OR1(A,B,w1);
OR OR2(w1, C, w2);
XOR XOR1(A, C, w3);
AND AND1(w2, w3, w4);
NOT NOT1(B, w5);
OR OR3(w4, w5, out);
endmodule

// (((A xor B) and C) or (A and (B or C))) xor (not B)
module ExpresieCustom(A, B, C, out);
input A, B, C;
output out;
wire w1, w2, w3, w4, w5, w6;

XOR XOR1(A, B, w1);
AND AND1(w1, C, w2);
OR OR1(B, C, w3);
AND AND2(A, w3, w4);
OR OR2(w2, w4, w5);
NOT NOT1(B, w6);
XOR XOR2(w5, w6, out);
endmodule

module Testbench;

reg a,b,c;
wire outA, outB, outCustom;

initial begin
    a = 0; b = 0; c = 0;
    #1 c = 1;
    #1 b = 1; c = 0;
    #1 c = 1;
    #1 a = 1; b = 0; c = 0;
    #1 c = 1;
    #1 b = 1; c = 0;
    #1 c = 1;
end

initial begin
    $monitor("Time=%0d A=%b B=%b C=%b outA=%b outB=%b outCustom=%b", $time, a, b, c, outA, outB, outCustom);
end

SubpunctulA SubA(a,b,c,outA);
SubpunctulB SubB(a,b,c,outB);
ExpresieCustom ExpCustom(a,b,c,outCustom);
endmodule