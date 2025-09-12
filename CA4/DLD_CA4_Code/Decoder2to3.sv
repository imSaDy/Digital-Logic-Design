module decoder (num, out);
    input logic [1:0] num;
    output logic out[0:2]; 
    always @(*) begin
        out[0] = 0; out[1] = 0; out[2] = 0; 
        case (num)
            2'b00: out[0] = 1;
            2'b01: out[1] = 1;
            2'b10: out[2] = 1;
        endcase
    end
endmodule
