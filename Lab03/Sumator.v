module XOR(in1, in2, out);

input in1, in2;
output reg out;

always @(in1 or in2)
begin
	out = in1 ^ in2;
end

endmodule

module OR(in1, in2, out);

input in1, in2;
output reg out;

always @(in1 or in2)
begin
	out = in1 | in2;
end

endmodule

module AND(in1, in2, out);

input in1, in2;
output reg out;

always @(in1 or in2)
begin
	out = in1 & in2;
end

endmodule

module semisumator(in1, in2, s, c);

input in1, in2;

output s;
output c;

XOR XOR1(in1,in2,s);
AND AND1(in1,in2,c);

endmodule

module sumator;

reg a,b,c;
wire w1,w2,w3;
wire s, cout;

semisumator semis1(a,b,w1,w2);
semisumator semis2(w1,c,s,w3);
OR OR1(w2,w3,cout);

initial begin
	a=0;b=0;c=0;
	#2 c=1;
	#2 b=1;c=0;
	#2 c=1;
	#2 a=1;b=0;c=0;
	#2 c=1;
	#2 b=1;c=0;
	#2 c=1;
end

initial begin
	$monitor("a=%b b=%b c=%b s=%b cout=%b",a,b,c,s,cout);
end


endmodule
