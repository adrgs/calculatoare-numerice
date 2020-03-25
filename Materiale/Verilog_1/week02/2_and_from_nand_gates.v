module NAND( in1, in2, out);

input in1, in2;
output out;

assign out = ~(in1 & in2);

endmodule

//----------------------------------------------------------------------------/

module AND( in1, in2, out);

input in1, in2;
output out;
wire w1;

NAND NAND1( in1, in2, w1);
NAND NAND2( w1, w1, out);

endmodule

//----------------------------------------------------------------------------/

module Testbench;

reg a, b;
wire out1, out2;

initial begin

a = 0; b = 0;
#1 a = 1;
#1 b = 1;
#1 a = 0;

end

initial begin
$monitor( "Time=%0d a=%b b=%b out1=%b out2=%b", $time, a, b, out1, out2);
end

// instantele modulelor AND si NAND
AND and_gate( a, b, out1);
NAND nand_gate( a, b, out2);


endmodule 



