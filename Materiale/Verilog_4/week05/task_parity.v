module tasks;

task parity;
       input [3:0] x;
       output z;
       z = ^ x;
endtask

// begin block must have a label if it contains declarations
// begin [ : label
//    [ local_declarations ] ]
//    statement
// end 
initial
    begin: init1 
       reg r;
       parity(4'b1101,r); // invocare task : 1011, 1111
       $display("p=%b",r);
    end

endmodule


