
//definirea modului my_nor
module my_nor(out,a,b);
    output out;
    input a,b;
    //conectari interne
    wire c;
    //asignarea liniilor de energie si referinta
    supply1 pwr;
    supply0 gnd;
    //instantierea tranzistorilor de comutare pmos
    pmos(c,pwr,b);
    pmos(out,c,a);
    //instantierea tranzistorilor de comutare nmos
    nmos(out,gnd,a);
    nmos(out,gnd,b);
endmodule


//modulul de test pentru poarta NOR
module stimulus;
    reg A,B;
    wire OUT;

    //instantiere modul my_nor
    my_nor n1(OUT,A,B);

    //testarea tuturor cazurilor
    initial
    begin
    A=1'b0;B=1'b0;
    #5 A=1'b0;B=1'b1;
    #5 A=1'b1;B=1'b0;
    #5 A=1'b1;B=1'b1;
    end

initial
    $monitor($time," OUT=%b A=%b B=%b",OUT,A,B);

endmodule



