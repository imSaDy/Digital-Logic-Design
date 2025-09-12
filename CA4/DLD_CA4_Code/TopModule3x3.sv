module TopModule3x3(clk, reset, data_in, start_address, add_to_mem, out, done3x3, start);
    input clk, reset, start; 
    input [7:0] data_in; 
    input [3:0] start_address; 
    wire start2x2, done2x2, loadst, selmux, EnC1, EnC2, loadC1, loadC2, end1, end2;
    output [3:0] add_to_mem;  
    output [15:0] out;
    output done3x3;  
    Det3x3_DataPath DP3X3(.clk(clk), .reset(reset), .start2x2(start2x2), .done2x2(done2x2), .data_in(data_in), .start_address(start_address), .loadst(loadst), .selmux(selmux), .add_to_mem(add_to_mem), .EnC1(EnC1), .EnC2(EnC2), .loadC1(loadC1), .loadC2(loadC2), .out(out), .end1(end1), .end2(end2));
    controller3x3 CTRL3X3(.done2x2(done2x2), .end1(end1), .start(start), .loadst(loadst), .start2x2(start2x2), .EnC1(EnC1), .EnC2(EnC2), .selmux(selmux), .loadC1(loadC1), .loadC2(loadC2), .end2(end2), .done3x3(done3x3), .clk(clk), .reset(reset));
endmodule