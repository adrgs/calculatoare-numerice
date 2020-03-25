
module fact;

task factorial;
         input [3:0] n;
         output [31:0] outfact;
         integer count;
         begin 
            outfact = 1;
            for (count=n;count>0;count=count-1)
                 outfact = outfact * count;
         end 
endtask
         
initial 
   begin : init1
       reg [3:0] n;
       reg [31:0] result;
       n = 4'b0101;       
       factorial( n, result);  
       $display("n=%d fact=%d", n, result);  
   end 

endmodule


