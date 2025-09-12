module signed_adder #(parameter n = 16)(A, B, C);
    input logic signed [n - 1:0] A;
    input logic signed [n - 1:0] B;
    output logic signed [n - 1:0] C;

    assign C = A + B;
endmodule
