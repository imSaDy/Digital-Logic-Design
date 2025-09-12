module Shift_register24 #(parameter N = 24)(input clk, rst, shift_en, par_load, [N - 1:0] par_in, ser_in, output [N - 1:0] par_out, ser_out);
    logic [N - 1:0] register; 
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : shift_register
            MSDFF msdff (.rst(rst), .clk(clk), .en(par_load | shift_en), .D(par_load ? par_in[i] : (i == N - 1 ? ser_in : register[i + 1])), .Q(register[i]));
        end
    endgenerate

    assign par_out = register;  
    assign ser_out = register[0]; 
endmodule

module Shift_register80 #(parameter N = 80)(input clk, rst, shift_en, par_load, [N - 1:0] par_in, ser_in, output [N - 1:0] par_out, ser_out);
    logic [N - 1:0] register; 
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : shift_register
            MSDFF msdff (.rst(rst), .clk(clk), .en(par_load | shift_en), .D(par_load ? par_in[i] : (i == N - 1 ? ser_in : register[i + 1])), .Q(register[i]));
        end
    endgenerate

    assign par_out = register;  
    assign ser_out = register[0]; 
endmodule