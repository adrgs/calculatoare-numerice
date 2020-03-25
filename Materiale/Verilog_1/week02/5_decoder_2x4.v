// decoder_tb.v

// 2x4 Decoder

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

`timescale 1ns / 1ps

// decoder.v

// 2x4 Decoder

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

// Truth table for 2x4 Decoder
//  A   B  |  D3  D2  D1  D0
//---------+-----------------
//  0   0  |   0   0   0   1   
//  0   1  |   0   0   1   0
//  1   0  |   0   1   0   0
//  1   1  |   1   0   0   0


module Decoder(A, B, D);

   input A, B;
   output [3:0] D;
   reg [3:0] D;

   always @ (A or B)
   begin
      if( A == 0 && B == 0 )
         D <= 4'b0001;

      else if ( A == 0 && B == 1 )
         D <= 4'b0010;

      else if ( A == 1 && B == 0 )
         D <= 4'b0100;

      else
         D <= 4'b1000;
   end

endmodule


module Testbench;

   reg A_t, B_t;
   wire [3:0] D_t;
           
   Decoder Decoder_1(A_t, B_t, D_t);
   
   initial
   begin

      //case 0
      A_t <= 0; B_t <= 0;
      #1 $display("D_t = %b", D_t);
	  
      //case 1
      A_t <= 0; B_t <= 1;
      #1 $display("D_t = %b", D_t);
	  
      //case 2
      A_t <= 1; B_t <= 0;
      #1 $display("D_t = %b", D_t);
	  
      //case 3
      A_t <= 1; B_t <= 1;
      #1 $display("D_t = %b", D_t);
	  
   end
endmodule

