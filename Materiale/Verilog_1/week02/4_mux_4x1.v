// mux_tb.v

// 4x1 MUX

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

`timescale 1ns / 1ps

// 4x1 MUX

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

// 4 data inputs, and 2 output.  Select inputs determine
// which data input passes through to the output

// Truth table for 4x1 MUX
// S1  S0  | D
// --------+-------
//  0   0  | input0
//  0   1  | input1
//  1   0  | input2
//  1   1  | input3

`timescale 1ns / 1ps

module Mux(Input0, Input1, Input2, Input3, Sel, Data_out);

   input [3:0] Input0;
   input [3:0] Input1;
   input [3:0] Input2;   
   input [3:0] Input3;
   input [2:0] Sel;
   output [3:0] Data_out;
   reg [3:0] Data_out;

   // constant declaration
   parameter S0 = 2'b00;
   parameter S1 = 2'b01;
   parameter S2 = 2'b10;
   parameter S3 = 2'b11;

   always @ (Sel or Input0 or Input1 or Input2 or Input3)
   begin
      case(Sel)
         S0: begin
            Data_out <= Input0;
         end
         S1: begin
            Data_out <= Input1;
         end
         S2: begin
            Data_out <= Input2;
         end
         S3: begin
            Data_out <= Input3;
         end
      endcase
   end
endmodule




module Testbench;

   reg [3:0] Input0_t, Input1_t, Input2_t, Input3_t;
   reg [2:0] Sel_t;
   wire [3:0] Data_out_t; 

   Mux Mux_1(Input0_t, Input1_t, Input2_t, Input3_t, Sel_t, Data_out_t);
   
   initial
   begin

      // assign values to input register
      Input0_t <= 0;
      Input1_t <= 1;
      Input2_t <= 2;
      Input3_t <= 3;

      //case 0 - Input0 value should be display on output
      Sel_t <= 0;
      #1 $display("Data_out_t = %b", Data_out_t);
	  
      //case 1 - Input1 value should be display on output
      Sel_t <= 1;
      #1 $display("Data_out_t = %b", Data_out_t);

      //case 2 - Input2 value should be display on output
      Sel_t <= 2;
      #1 $display("Data_out_t = %b", Data_out_t);

      //case 3 - Input3 value should be display on output
      Sel_t <= 3;
      #1 $display("Data_out_t = %b", Data_out_t);

      // reassign value to input register Input0 and display on output
      Input0_t = 8;
      Sel_t <= 0;
      #1 $display("Data_out_t = %b", Data_out_t);

      // reassign value to input register Input0 and display on output
      Input0_t = 4;
      Sel_t <= 0;
      #1 $display("Data_out_t = %b", Data_out_t);
		
   end
endmodule


