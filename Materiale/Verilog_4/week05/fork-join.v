module fork_join;

reg [3:0] Data1;
reg [3:0] Data2;


initial
fork
  #4 Data1 = 4'b1111;
  #5 Data1 = 4'b1101;     // This is executed last        
  #2 Data1 = 4'b1001;     // This is executed first
join                     // It completes at time 5


initial
begin
  #4 Data2 = 4'b1111;      // This is executed first
  #5 Data2 = 4'b1101;              
  #2 Data2 = 4'b1001;      // This is executed last
end                       // It completes at time 11


initial
   $monitor( "Time = %d  Data1 = %h  Data2 = %h\n", $time, Data1, Data2); 


endmodule

