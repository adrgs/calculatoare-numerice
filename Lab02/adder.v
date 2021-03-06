module Adder(A,B, Result);

input [3:0] A;
input [3:0] B;
output [3:0] Result;
reg [3:0] Result;

always @ (A or B)
begin
  Result <= A+B;
end

endmodule


module Test;

reg [3:0] A_t;
reg [3:0] B_t;
wire [3:0] Result_t;

Adder Adder_1(A_t, B_t, Result_t);

initial begin

A_t <= 0; B_t <= 0;
#1 $display("Result_t = %b", Result_t);

A_t <= 6; B_t <= 1;
#1 $display("Result_t = %b", Result_t);

A_t <= 1; B_t <= 0;
#1 $display("Result_t = %b", Result_t);

A_t <= 10; B_t <= 10;
#1 $display("Result_t = %b", Result_t);
end

endmodule
