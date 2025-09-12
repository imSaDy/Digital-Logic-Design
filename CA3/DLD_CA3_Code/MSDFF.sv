module MSDFF(input rst, clk, en, D, output Q);
    wire Qm, Qmb, Qb;
    D_Latch master (.D(D), .rst(rst), .en(en), .clk(~clk), .Q(Qm), .Qb(Qmb));
    D_Latch slave (.D(Qm), .rst(rst), .en(en), .clk(clk), .Q(Q), .Qb(Qb));
endmodule