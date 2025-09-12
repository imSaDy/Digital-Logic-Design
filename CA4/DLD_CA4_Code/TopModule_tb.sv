`timescale 1ns/1ns

module Det2x2_TestBench;
    logic clk;
    logic reset;
    logic start;
    logic [3:0] start_add; 
    wire done;
    wire [15:0] out;
    wire [3:0] add_to_mem; 
    initial clk = 0;
    always #5 clk = ~clk;
    wire [7:0] data_in; 
    TopModule2x2 uut (.clk(clk), .reset(reset), .start(start), .done(done), .out(out), .start_add(start_add), .data_in(data_in), .add_to_mem(add_to_mem));
    ROM rom(add_to_mem, data_in);
    initial begin
        reset = 1;
        start = 0;
        start_add = 4'b0000;
        #10;
        reset = 0;
        #10;
        start = 1;
        #10;
        start = 0; 
        #100;
        start_add = 4'b0001; 
        #5; 
        start = 1; 
        #10; 
        start = 0;
        #100;
        start_add = 4'b0010; 
        #10; 
        start = 1;
        #50; 
        start = 0; 
        #100; 
        start_add = 4'b0011;
        #10; 
        start = 1; 
        #10; 
        start = 0; 
        #200;  
        $stop;
    end

endmodule
