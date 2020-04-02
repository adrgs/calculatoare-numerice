

//definirea modulului inversor
module my_not(out,in);
   input in;
   output out;
   //declararea surse de energie si a nivelului de referinta
   supply1 pwr;
   supply0 gnd;
   //instantierea tranzistorilor nmos si pmos
   nmos(out,gnd,in);
   pmos(out,pwr,in);
endmodule


//modulul de test pentru inversor
module stimulus;
    reg A,B;
    wire OUT;

    //instantiere modul my_nor
    my_not n1(OUT,A);

    //testarea tuturor cazurilor
    initial
    begin
    A=1'b0;
    #10 A=1'b1;
    #15 A=1'b0;
    #20 A=1'b1;
    end

initial
    $monitor($time," OUT=%b A=%b",OUT,A);

endmodule



