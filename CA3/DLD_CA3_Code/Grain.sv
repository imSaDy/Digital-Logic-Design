module Grain (input logic clk, rst, shift_en, par_load, [23:0] nfsr_seed, [79:0] lfsr_seed, output logic [23:0] nfsr_par_out, [79:0] lfsr_par_out, grain_out);
    logic nfsr_ser_out, lfsr_ser_out;
    logic h_out;

    LFSR lfsr (.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .seed(lfsr_seed), .par_out(lfsr_par_out), .ser_out(lfsr_ser_out));
    NFSR nfsr (.clk(clk), .rst(rst), .shift_en(shift_en), .par_load(par_load), .lfsr_out(lfsr_ser_out), .seed(nfsr_seed), .par_out(nfsr_par_out), .ser_out(nfsr_ser_out));
    
    assign h_out = lfsr_par_out[0] ^ lfsr_par_out[3] ^ (lfsr_par_out[1] & lfsr_par_out[2]) ^ nfsr_par_out[0] ^ (nfsr_par_out[1] & lfsr_par_out[5]) ^ (nfsr_par_out[3] & lfsr_par_out[7]) ^ (lfsr_par_out[8] & lfsr_par_out[13] & nfsr_par_out[5]) ^ nfsr_par_out[2];
    assign grain_out = h_out ^ nfsr_ser_out;
endmodule
