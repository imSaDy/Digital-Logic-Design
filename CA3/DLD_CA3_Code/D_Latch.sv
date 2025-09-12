module D_Latch(input D, rst, en, clk, output Q, Qb);
    wire R; 
    not(R, D); 
    wire S1; 
    wire rstn; 
    not(rstn, rst); 
    nand(S1, D, clk, en, rstn); 
    wire R1; 
    nand(R1, R, clk, en);
    nand(Qb, R1, rstn, Q); 
    nand(Q, S1, Qb);
endmodule