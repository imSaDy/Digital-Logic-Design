module Det2x2_DataPath(clk, reset, data_in, loadA, initC, EnC, loadC, add_to_mem, loadmul, out);
    input logic clk; 
    input logic reset; 
    input logic signed [7:0] data_in; 
    input logic loadA[2:1][2:1];
    input logic EnC, loadC; 
    input logic [3:0] initC;
    output logic [3:0] add_to_mem; 
    input logic loadmul[2:1]; 
    logic [15:0] mulres;
    output logic [15:0] out;
    logic signed [7:0] A[2:1][2:1];
    logic signed mul_in[2:1]; 
    logic signed [15:0] Reg[2:1]; 

    register #(.n(8)) regA11(.clk(clk), .reset(reset), .load(loadA[1][1]), .D(data_in), .Q(A[1][1]));
    register #(.n(8)) regA12(.clk(clk), .reset(reset), .load(loadA[1][2]), .D(data_in), .Q(A[1][2]));
    register #(.n(8)) regA21(.clk(clk), .reset(reset), .load(loadA[2][1]), .D(data_in), .Q(A[2][1]));
    register #(.n(8)) regA22(.clk(clk), .reset(reset), .load(loadA[2][2]), .D(data_in), .Q(A[2][2]));

    register #(.n(16)) regmul1(.clk(clk), .reset(reset), .load(loadmul[1]), .D(mulres), .Q(Reg[1]));
    register #(.n(16)) regmul2(.clk(clk), .reset(reset), .load(loadmul[2]), .D(mulres), .Q(Reg[2]));

    counter #(.n(4)) start_add(.clk(clk), .reset(reset), .EnC(EnC), .initC(initC), .count(add_to_mem), .loadC(loadC));

    signed_multiplier multiplier(.A((loadmul[1] ? A[1][1] : (loadmul[2] ? A[1][2] : 0))), .B((loadmul[1] ? A[2][2] : (loadmul[2] ? A[2][1] : 0))), .C(mulres));

    signed_subtractor subtractor(.A(Reg[1]), .B(Reg[2]), .C(out)); 
endmodule