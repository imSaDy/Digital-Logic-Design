module register #(parameter n = 8)(clk, reset, load, D, Q);
    input logic clk;
    input logic reset;
    input logic load;
    input logic signed [n - 1:0] D;
    output logic signed [n - 1:0] Q; 
    
    always @(posedge clk or posedge reset) begin
        if (reset) 
            Q <= 0;
        else if (load) 
            Q <= D; 
    end
endmodule
