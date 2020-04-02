

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


//definirea modulului bistabil D CMOS
module dff(q,qbar,d,clk);
   input d,clk;
   output q,qbar;
   //conexiuni interne 
   wire e;
   wire nclk;

   //instantierea inversorului
   my_not nt(nclk,clk);
   //instantierea portilor CMOS
   cmos(e,d,clk,nclk); //C1 se inchide (e=d) daca clk=1
   cmos(e,q,nclk,clk); //C2 se inchide (e=q) daca clk=0
   //instantiera inversoarelor
   my_not nt1(qbar,e);
   my_not nt2(q,qbar);
endmodule


//modulul de test pentru inversor
module stimulus;
    reg d, clk;
    wire q, qbar;

    //instantiere modul my_nor
    dff bistabil_D_cmos(q,qbar,d,clk);

    //testarea tuturor cazurilor
    initial
    begin
       clk=1'b0; 
       d=1'b1;
    #1 clk = ~clk; d=1'b1;
    #1 clk = ~clk; d=1'b1;
    #1 clk = ~clk; d=1'b1;
    #1 clk = ~clk; d=1'b1;
    #1 clk = ~clk; d=1'b0;
    #1 clk = ~clk; d=1'b0;
    #1 clk = ~clk; d=1'b0;
    #1 clk = ~clk; d=1'b0;
    #1 clk = ~clk; d=1'b1;
    #1 clk = ~clk; d=1'b1;
    #1 clk = ~clk; d=1'b0;
    #1 clk = ~clk; d=1'b1;
    end

initial
    $monitor($time," q=%b qbar=%b d=%b clk=%b",q,qbar,d,clk);

endmodule



