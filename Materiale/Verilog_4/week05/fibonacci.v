// fib_tb.v

// Fibonacci Number Generator - Testbench

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

`timescale 1ns / 1ps


// fib.v

// Fibonacci Number Generator

// ------------------------------------------------------------------
// Copyright (c) 2006 Susan Lysecky, University of Arizona
// Permission to copy is granted provided that this header remains
// intact. This software is provided with no warranties.
// ------------------------------------------------------------------

// Fibonacci numbers are a sequence of numbers defined by
//         | 0                if n = 0
// F(n) =  | 1                if n = 1
//         | F(n-1) + F(n-2)  if n > 1
// Simply, after 0 and 1, each following number is the sum of the two
// numbers before it (i.e. 0, 1, 1, 2, 3, 5, 8, 13, ...)

// The Fibonacci number generator FibGen has two inputs, enb and rst,
// and one output, out. The number generator counts up, following
// the defined sequence when enb=1. when rst=1 the output is reset
// the beginning of the Fibonacci series (0) and remains there until
// rst=0. The rst input has precedence over the enb input. The output
// port (out) contains the current Fibonacci value.

`timescale 1ns / 1ps

module FibGen(clk, rst, enb, out);

   input clk, rst, enb;
   output [16:0] out;
   reg [16:0] out;

   // states
   parameter S0 = 3'b000;
   parameter S1 = 3'b001;
   parameter S2 = 3'b010;
   parameter S3 = 3'b011;
   parameter S4 = 3'b100;

   // used to initialize registers
   parameter Zero_16 = 16'b0000000000000000;
   parameter One_16 = 16'b0000000000000001;

   reg [16:0] reg_0 = Zero_16;
   reg [16:0] reg_1 = One_16;
   reg [16:0] fib = Zero_16;

   reg [2:0] State;
   
   always @ (posedge rst or posedge clk)
   begin
      if( rst == 1 )
      begin
         reg_0 = Zero_16;
         reg_1 = One_16;
         fib = Zero_16;

         State <= S0;
         out <= Zero_16;
      end
      else 
		begin
         case( State )
            S0:
				begin
               // determine next state
               if( enb == 1 )
                  State <= S1;
               else
                  State <= S0;

               // assign output value
               out <= reg_0;
               fib <= reg_0;
            end

            S1: 
				begin
               // determine next state
               if( enb == 1 )
                  State <= S2;
               else
                  State <= S1;

               // assign output value
               out <= reg_1;
               fib <= reg_1;

            end

            S2: 
				begin
               // determine next state
               if( enb == 1 )
                  State <= S2;
               else
                  State <= S3;

               // update values and assign output value
               out <= reg_0 + reg_1;
               fib <= reg_0 + reg_1;
               reg_0 <= reg_1;
               reg_1 <= reg_0 + reg_1;
            end

            S3: 
				begin
               // determine next state
               if( enb == 1 )
                  State <= S2;
               else 
                  State <= S3;

               // assign output value
               out <= fib;
            end
			endcase
      end
   end
endmodule


module Testbench;

   reg clk_t, rst_t, enb_t;
   wire [16:0] out_t;

   FibGen FibGen_1(clk_t, rst_t, enb_t, out_t);
   
   always
   begin
      clk_t <= 0;
      #25;
      clk_t <= 1;
      #25;
   end
	
   initial
   begin

      // reset
      rst_t <= 1; enb_t <= 0;
      #100;
		
      //case 0
      rst_t <= 0; enb_t <= 0;
      #100 $display("out_t = %b", out_t);
	  
      //case 1
      enb_t <= 1;
      #500 $display("out_t = %b", out_t);
	  
      //case 2
      enb_t <= 0;
      #100 $display("out_t = %b", out_t);
	  
      //case 3
      rst_t <= 1; enb_t <= 1;
      #100 $display("out_t = %b", out_t);
	  
   end
endmodule

