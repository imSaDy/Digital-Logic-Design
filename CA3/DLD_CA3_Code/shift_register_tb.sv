`timescale 1ns/1ns
module tb_Shift_register80;
    parameter N = 80;
    logic clk;
    logic rst;
    logic shift_en;
    logic par_load;
    logic [N - 1:0] par_in;
    logic ser_in;
    wire [N - 1:0] par_out;
    wire ser_out;
    Shift_register80 #(N) uut(.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .par_in(par_in), .ser_in(ser_in), .par_out(par_out), .ser_out(ser_out));
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        rst = 0; shift_en = 0; par_load = 0; par_in = 0; ser_in = 0;
        rst = 1; #10;
        rst = 0; #10;
        par_in = 80'h88000000000000000000; par_load = 1; #10;
        par_load = 0; ser_in = 0; shift_en = 1;
        repeat (24) #10;
        shift_en = 0; ser_in = 1; shift_en = 1;
        repeat (32) #10;
        shift_en = 0; rst = 1; #10;
        rst = 0;
        $stop;
    end
endmodule

module tb_Shift_register24;
    parameter N = 24;
    logic clk;
    logic rst;
    logic shift_en;
    logic par_load;
    logic [N - 1:0] par_in;
    logic ser_in;
    wire [N - 1:0] par_out;
    wire ser_out;
    Shift_register24 #(N) uut(.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .par_in(par_in), .ser_in(ser_in), .par_out(par_out), .ser_out(ser_out));
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        rst = 0; shift_en = 0; par_load = 0; par_in = 0; ser_in = 0;
        rst = 1; #10;
        rst = 0; #10;
        par_in = 24'h880000; par_load = 1; #10;
        par_load = 0; ser_in = 0; shift_en = 1;
        repeat (24) #10;
        shift_en = 0; ser_in = 1; shift_en = 1;
        repeat (32) #10;
        shift_en = 0; rst = 1; #10;
        rst = 0;
        $stop;
    end
endmodule
