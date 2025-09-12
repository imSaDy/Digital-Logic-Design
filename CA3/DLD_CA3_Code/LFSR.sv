module LFSR(input clk, rst, shift_en, par_load, [79:0] seed, output [79:0] par_out, ser_out);
    wire f_out; 
    assign f_out = par_out[62] ^ par_out[51] ^ par_out[38] ^ par_out[23] ^ par_out[13] ^ par_out[0];
    Shift_register80 #(80) shift_register(.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .par_in(seed), .ser_in(f_out), .par_out(par_out), .ser_out(ser_out));
endmodule
