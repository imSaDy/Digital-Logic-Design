module NFSR(input clk, rst, shift_en, par_load, lfsr_out, [23:0] seed, output [23:0] par_out, output ser_out);
    wire [23:0] register_out;
    wire g_out;            
    assign g_out = register_out[0] ^ register_out[5] ^ register_out[6] ^ register_out[9] ^ register_out[17] ^ register_out[22] ^ (register_out[4] & register_out[13]) ^ (register_out[8] & register_out[16]) ^ (register_out[5] & register_out[11] & register_out[14]) ^ (register_out[2] & register_out[5] & register_out[8] & register_out[10]);
    assign par_out = register_out;
    assign ser_out = register_out[0];
    Shift_register24 #(24) shift_register(.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .par_in(seed), .ser_in(g_out ^ lfsr_out), .par_out(register_out), .ser_out());
endmodule
