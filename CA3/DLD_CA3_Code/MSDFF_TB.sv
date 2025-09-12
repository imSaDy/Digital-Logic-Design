`timescale 1ns/1ns
module tb_MSDFF;
    logic rst, clk, en, D;
    wire Q;
    MSDFF uut (.rst(rst), .clk(clk), .en(en), .D(D), .Q(Q)); 
    initial clk = 0;
    always #5 clk = ~clk; 

    initial begin
        rst = 1; en = 0; D = 0; #10;
        rst = 0; en = 1; D = 0; #10;
        D = 1; #10;
        D = 0; #10;
        en = 0; #10;
        D = 1; #10;
        en = 1; #10;
        rst = 1; #10;
        rst = 0; D = 0; #20;
        $stop;
    end
endmodule
