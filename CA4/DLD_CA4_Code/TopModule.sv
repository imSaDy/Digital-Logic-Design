module TopModule2x2(clk, reset, start, done, out, start_add, data_in, add_to_mem);
    input clk, reset, start; 
    output done; 
    output [15:0] out; 
    input logic signed [7:0] data_in; 
    input [3:0] start_add; 
    output wire [3:0] add_to_mem; 
    wire loadC, EnC; 
    logic loadA[2:1][2:1];
    logic loadmul[2:1];
    Det2x2_DataPath DP(.clk(clk), .reset(reset), .data_in(data_in), .loadA(loadA), .initC(start_add), .EnC(EnC), .loadC(loadC), .add_to_mem(add_to_mem), .loadmul(loadmul), .out(out));
    controller CTRL(.start(start), .loadC(loadC), .EnC(EnC), .loadA(loadA), .loadmul(loadmul), .done(done), .reset(reset), .clk(clk));
endmodule