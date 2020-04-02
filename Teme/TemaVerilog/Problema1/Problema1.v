// Module pentru porti logice
module TranzNAND(a, b, c);
input a, b;
output c;

wire w1;

supply1 pwr;
supply0 gnd;

pmos(c, pwr, a);
pmos(c, pwr, b);

nmos(w1, gnd, b);
nmos(c, w1, a);
endmodule

module NAND(in1, in2, out);
input in1, in2;
output out;

TranzNAND TranzNAND(in1, in2, out);
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
module SubpunctulA_Struct(A, B, C, out);
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

module SubpunctulA_Comp(A, B, C, out);
input A,B,C;
output out;

assign out = ((A & B) | (~C)) ^ ((~B) | C);
endmodule

// ( ( A or B or C) and ( A xor C) ) or (not B)
module SubpunctulB_Struct(A, B, C, out);
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

module SubpunctulB_Comp(A, B, C, out);
input A,B,C;
output out;

assign out = ((A | B | C) & (A ^ C)) | (~B);
endmodule

// (((A xor B) and C) or (A and (B or C))) xor (not B)
module ExpresieCustom_Struct(A, B, C, out);
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

module ExpresieCustom_Comp(A, B, C, out);
input A,B,C;
output out;

assign out = (((A ^ B) & C) | (A & (B | C))) ^ (~ B);
endmodule

module Testbench;

reg a,b,c;
wire outA_struct, outB_struct, outCustom_struct;
wire outA_comp, outB_comp, outCustom_comp;

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
    $monitor("Time=%0d A=%b B=%b C=%b outA_struct=%b outB_struct=%b outCustom_struct=%b outA_comp=%b outB_comp=%b outCustom_comp=%b", $time, a, b, c, outA_struct, outB_struct, outCustom_struct, outA_comp, outB_comp, outCustom_comp);
end

SubpunctulA_Struct SubA_struct(a,b,c,outA_struct);
SubpunctulB_Struct SubB_struct(a,b,c,outB_struct);
ExpresieCustom_Struct ExpCustom_struct(a,b,c,outCustom_struct);
SubpunctulA_Comp SubA_comp(a,b,c,outA_comp);
SubpunctulB_Comp SubB_comp(a,b,c,outB_comp);
ExpresieCustom_Comp ExpCustom_comp(a,b,c,outCustom_comp);
endmodule