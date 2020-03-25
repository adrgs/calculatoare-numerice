
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


//definirea modulului multiplexor 2:1
module my_mux(out,s,i0,i1);
   output out;
   input s,i0,i1;
   //conectare interna
   wire sbar;
   //complementul semnalului s se determina cu poarta my_nor
   //anterior definita
   my_nor nt(sbar,s,s);
   //instantierea elementelor de comutare cmos
   cmos(out,i0,sbar,s);
   cmos(out,i1,s,sbar);
endmodule


//modulul de test pentru poarta NOR
module stimulus;
    reg S,A,B;
    wire OUT;

    //instantiere modul my_nor
    my_mux m1(OUT,S,A,B);

    //testarea tuturor cazurilor
    initial
    begin
    A=1'b0;B=1'b1; S=1'b0;
    #1 A=1'b1;   
    #1 A=1'b1; S=1'b1;
    #1 A=1'b0;B=1'b0; 
    #1 A=1'b1; 
    #1 S=1'b0;
    end

initial
    $monitor($time," OUT=%b S=%b A=%b B=%b",OUT,S,A,B);

endmodule



