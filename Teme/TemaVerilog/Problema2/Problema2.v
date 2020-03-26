// Afisor cu 7 segmente

// Transorma un numar pe 4 biti in semnale pentru afisorul cu 7 segmente
module Decodor7Segmente(in, out);
input [3:0] in;
output [6:0] out;
reg [6:0] out;

parameter case0 = 4'b0000;
parameter case1 = 4'b0001;
parameter case2 = 4'b0010;
parameter case3 = 4'b0011;
parameter case4 = 4'b0100;
parameter case5 = 4'b0101;
parameter case6 = 4'b0110;
parameter case7 = 4'b0111;
parameter case8 = 4'b1000;
parameter case9 = 4'b1001;
parameter case10 = 4'b1010;
parameter case11 = 4'b1011;
parameter case12 = 4'b1100;
parameter case13 = 4'b1101;
parameter case14 = 4'b1110;
parameter case15 = 4'b1111;

always @ (in)

begin
    case (in)
    case0: begin
         out <= 7'b1111110;
    end
    case1: begin
         out <= 7'b0110000;
    end
    case2: begin
         out <= 7'b1101101;
    end
    case3: begin
         out <= 7'b1111001;
    end
    case4: begin
         out <= 7'b0110011;
    end
    case5: begin
         out <= 7'b1011011;
    end
    case6: begin
         out <= 7'b1011111;
    end
    case7: begin
         out <= 7'b1110000;
    end
    case8: begin
         out <= 7'b1111111;
    end
    case9: begin
         out <= 7'b1110011;
    end
    case10: begin
         out <= 7'b1110111;
    end
    case11: begin
         out <= 7'b0011111;
    end
    case12: begin
         out <= 7'b1001110;
    end
    case13: begin
         out <= 7'b0111101;
    end
    case14: begin
         out <= 7'b1001111;
    end
    case15: begin
         out <= 7'b1000111;
    end
    endcase
end
endmodule


module Testbench;
reg [3:0] in;
wire [6:0] out;

Decodor7Segmente Decodor(in, out);

initial begin
    in <= 0;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 1;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 2;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 3;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 4;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 5;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 6;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 7;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 8;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 9;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 10;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 11;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 12;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 13;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 14;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
    in <= 15;
    #1 $display("Numar: %d (%b)",$unsigned(in), in); afisare(out);
end

/*
    segmente[6:0]
    0000000
    abcdefg

    segmente[6] == a
    ...
    segmente[0] == f

    #### - a
    #  #
f - #  # - b
    #  #
    #  #
    #### - g
    #  #
e - #  # - c
    #  # 
    #  #
    #### - d
*/
task afisare;
input [6:0] segmente;
reg [8*4:0] a, fsib, g, esic, d;
begin
if (segmente[6] == 1)
    a = "####";
else 
    a = "    ";

if (segmente[3] == 1)
    d = "####";
else
    d = "    ";

if (segmente[0] == 1)
    g = "####";
else 
    g = "    ";

if (segmente[4] == 1 && segmente[2] == 1)
    esic = "#  #";
else if (segmente[4] == 1)
    esic = "   #";
else if (segmente[2] == 1)
    esic = "#   ";
else 
    esic = "    ";

if (segmente[5] == 1 && segmente[1] == 1)
    fsib = "#  #";
else if (segmente[5] == 1)
    fsib = "   #";
else if (segmente[1] == 1)
    fsib = "#   ";
else 
    fsib = "    ";

$display("Segmente - %b\nAfisor:\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s", segmente, a, fsib,fsib,fsib,fsib, g, esic,esic,esic,esic,d);
end
endtask

endmodule