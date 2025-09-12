module counter #(parameter n = 8)(clk, reset, EnC, initC, count, loadC);
    input logic clk;
    input logic reset;
    input logic EnC;
    input logic [n - 1:0] initC;
    input logic loadC; 
    output logic [n - 1:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) 
            count <= 0;
        else if (loadC)
            count <= initC;
        else if (EnC)
            count <= count + 1;
    end
endmodule
