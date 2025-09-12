`timescale 1ns/1ns
module tb_NFSR;
    logic clk;
    logic rst;
    logic shift_en;
    logic par_load;
    logic [23:0] seed;
    wire [23:0] par_out;
    wire ser_out;
    NFSR uut (.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .lfsr_out(0), .seed(seed), .par_out(par_out), .ser_out(ser_out));
    initial clk = 0;
    always #5 clk = ~clk; 
    initial begin
        shift_en = 0; par_load = 0; seed = 0; rst = 1; #10;
        par_load = 1; rst = 0; seed = 24'habcabc ; #10;
        par_load = 0; shift_en = 1;
        repeat (9) #10;
        rst = 1; #10;
        rst = 0;
        $stop;
    end
endmodule
