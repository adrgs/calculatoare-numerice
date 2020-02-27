module Mux(input0, input1, input2, input3, sel, data_out);

input [3:0] input0;
input [3:0] input1;
input [3:0] input2;
input [3:0] input3;
input [1:0] sel;
output [3:0] data_out;
reg [3:0] data_out;

parameter s0 = 2'b00; // 2'b - constanta
parameter s1 = 2'b01;
parameter s2 = 2'b10;
parameter s3 = 2'b11;

always @ (input0 or input1 or input2 or input3 or sel)

begin
	case (sel)
	s0: begin
	data_out <= input0;
	end
	s1: begin
	data_out <= input1;
	end
	s2: begin
	data_out <= input2;
	end
	s3: begin
	data_out <= input3;
	end
	endcase
end

endmodule

module Test;

reg [3:0] input0;
reg [3:0] input1;
reg [3:0] input2;
reg [3:0] input3;
reg [1:0] sel;
wire [3:0] data_out; 

Mux multiplexor(input0,input1,input2,input3, sel, data_out);

initial begin
	input0 <= 0;
	input1 <= 1;
	input2 <= 2;
	input3 <= 3;
	
	sel <= 0;
	#1 $display("input0=%b, input1=%b, input2=%b, input3=%b, sel=%b, data_out=%b", input0, input1, input2, input3, sel, data_out);

	sel <= 1;
	#1 $display("input0=%b, input1=%b, input2=%b, input3=%b, sel=%b, data_out=%b", input0, input1, input2, input3, sel, data_out);

	sel <= 2;
	#1 $display("input0=%b, input1=%b, input2=%b, input3=%b, sel=%b, data_out=%b", input0, input1, input2, input3, sel, data_out);

	sel <= 3;
	#1 $display("input0=%b, input1=%b, input2=%b, input3=%b, sel=%b, data_out=%b", input0, input1, input2, input3, sel, data_out);

	input0 <= 8;
	sel <= 0;
	#1 $display("input0=%b, input1=%b, input2=%b, input3=%b, sel=%b, data_out=%b", input0, input1, input2, input3, sel, data_out);

	input0 <= 4;
	sel <= 0;
	#1 $display("input0=%b, input1=%b, input2=%b, input3=%b, sel=%b, data_out=%b", input0, input1, input2, input3, sel, data_out);


end

endmodule	
 

