`timescale 1ns/1ns
module tb_LFSR;
    logic clk;
    logic rst;
    logic shift_en;
    logic par_load;
    logic [79:0] seed;
    wire [79:0] par_out;
    wire ser_out;
    LFSR uut (.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .seed(seed), .par_out(par_out), .ser_out(ser_out));
    initial clk = 0;
    always #5 clk = ~clk; 
    initial begin
        shift_en = 0; par_load = 0; seed = 80'b0; rst = 1; #10;
        rst = 0; seed = 80'hcccccccccccccccccccc;
        par_load = 1; #10;
        par_load = 0; shift_en = 1;
        repeat (9) #10;
        rst = 1; #10;
        rst = 0;
        $stop;
    end
endmodule
