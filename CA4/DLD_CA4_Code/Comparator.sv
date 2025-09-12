module comparator #(parameter n = 8)(a, b, equal);
    input logic [n - 1:0] a;
    input logic [n - 1:0] b;
    output logic equal; 
    
    assign equal = (a == b);
endmodule