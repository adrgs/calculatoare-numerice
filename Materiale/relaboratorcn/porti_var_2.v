module AND(A,B,C);
  input A,B;
  output C;
  reg C;

  always @ (A or B)
  begin
    C=A&B;
  end
endmodule

module OR(A,B,C);
  input A,B;
  output C;
  reg C;
  
  always @ (A or B)
  begin
    C=A|B;
  end
endmodule

module NOT(A,B);
  input A;
  output B;
  reg B;

  always @ (A)
  begin
    B=!A;
  end
endmodule


module testbench;
  reg A,B,C;
  wire w1,w2,w3,w4,w5,out;

AND AND1(A,B,w1);
AND AND2(A,B,w2);
NOT NOT1(C,w3);

NOT NOT2(w1,w4);
AND AND3(w2,w3,w5);

OR OR1(w4,w5,out);

initial
begin

A<=0; B<=0; C<=0;
#1 $display("A=%b, B=%b, C=%b out=%b",A,B,C,out);

A<=0; B<=0; C<=1;
#1 $display("A=%b, B=%b, C=%b out=%b",A,B,C,out);

A<=0; B<=1; C<=0;
#1 $display("A=%b, B=%b, C=%b out=%b",A,B,C,out);

A<=1; B<=0; C<=0;
#1 $display("A=%b, B=%b, C=%b out=%b",A,B,C,out);

A<=0; B<=1; C<=1;
#1 $display("A=%b, B=%b, C=%b out=%b",A,B,C,out);

A<=1; B<=0; C<=1;
#1 $display("A=%b, B=%b, C=%b out=%b",A,B,C,out);

A<=1; B<=1; C<=0;
#1 $display("A=%b, B=%b, C=%b out=%b",A,B,C,out);

A<=1; B<=1; C<=1;
#1 $display("A=%b, B=%b, C=%b out=%b",A,B,C,out);
end
endmodule

