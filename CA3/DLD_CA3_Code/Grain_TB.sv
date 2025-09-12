`timescale 1ns/1ns
module tb_Grain;
    logic clk, rst, shift_en, par_load;
    logic [23:0] nfsr_seed;
    logic [79:0] lfsr_seed;
    wire [23:0] nfsr_par_out;
    wire [79:0] lfsr_par_out;
    wire grain_out;

    Grain uut (.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .nfsr_seed(nfsr_seed), .lfsr_seed(lfsr_seed), .nfsr_par_out(nfsr_par_out), .lfsr_par_out(lfsr_par_out), .grain_out(grain_out));

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        rst = 1; shift_en = 0; par_load = 0; nfsr_seed = 24'h4e21ab; lfsr_seed = 80'hcdcab96c00cc98724d50; 
        #20 rst = 0;
        par_load = 1; #10; par_load = 0; shift_en = 1;
        repeat (32) #10; 
        $stop;
    end
endmodule
