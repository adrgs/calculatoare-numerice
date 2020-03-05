module XOR(in1, in2, out);

input in1, in2;
output reg out;

always @(in1 or in2)
begin
	out = in1 ^ in2;
end

endmodule

module AND(in1, in2, out);

input in1, in2;
output reg out;

always @(in1 or in2)
begin
	out = (~in1) & in2;
end

endmodule


module Testbench;

reg a,b;
output c, s;

initial begin
	a=0;b=0;
	#1 b=1;
	#1 a=1;b=0;
	#1 b=1;
end

initial begin
	$monitor("a=%b b=%b s=%b c=%b",a,b,s,c);
end

XOR XOR1(a,b,s);
AND AND1(a,b,c);

endmodule
