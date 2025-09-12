`timescale 1ns/1ns
module tb_D_Latch;
    logic D, rst, en, clk;
    wire Q, Qb;

    D_Latch uut (.D(D), .rst(rst), .en(en), .clk(clk), .Q(Q), .Qb(Qb));

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        rst = 1; en = 0; D = 0; #10;
        rst = 0; en = 1; D = 0; #10;
        D = 1; #10;
        rst = 1; #10;
        rst = 0; #10;
        D = 1; #10;
        rst = 1; #20;
        D = 0; #10;
        rst = 0; #20;
        en = 0; #10;
        D = 1; #20;
        $stop;                       
    end
endmodule
