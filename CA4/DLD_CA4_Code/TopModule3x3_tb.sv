`timescale 1ns/1ns

module Det3x3_TestBench;
    logic clk;
    logic reset;
    logic start;
    logic [3:0] start_add; 
    wire [15:0] out;
    wire [3:0] add_to_mem; 
    initial clk = 0;
    always #5 clk = ~clk;
    wire [7:0] data_in; 
    wire done3x3; 
    TopModule3x3 uut (.clk(clk), .reset(reset), .start(start), .done3x3(done3x3), .out(out), .start_address(start_add), .data_in(data_in), .add_to_mem(add_to_mem));
    ROM rom(add_to_mem, data_in);
    initial begin
        reset = 1;
        start = 0;
        start_add = 4'b0000; 
        #10;
        reset = 0;
        #10;
        start_add = 4'b0000;
        start = 1;
        #10;
        start = 0; 
        #500;
        start_add = 4'b0001; 
        #10; 
        start = 1; 
        #10; 
        start = 0; 
        #500;
        start_add = 4'b0010; 
        #10; 
        start = 1; 
        #10; 
        start = 0; 
        #500; 
        start_add = 4'b0011; 
        #10; 
        start = 1; 
        #10; 
        start = 0; 
        #500;  
        start_add = 4'b0100; 
        #10; 
        start = 1; 
        #10; 
        start = 0; 
        #500; 
        start_add = 4'b0101; 
        #10; 
        start = 1; 
        #10; 
        start = 0; 
        #500; 
        start_add = 4'b0110; 
        #10; 
        start = 1; 
        #10; 
        start = 0; 
        #500;
        $stop;
    end

endmodule
