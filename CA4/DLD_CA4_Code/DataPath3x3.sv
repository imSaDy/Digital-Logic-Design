module Det3x3_DataPath(clk, reset, start2x2, done2x2, data_in, start_address, loadst, selmux, add_to_mem, EnC1, EnC2, loadC1, loadC2, out, end1, end2);
    input clk, reset ,loadst, selmux, EnC1, EnC2, loadC1, loadC2, start2x2; 
    input logic signed [7:0] data_in; 
    input [3:0] start_address; 
    output done2x2, end1, end2;
    output [15:0] out;
    output [3:0] add_to_mem;  
    logic signed [15:0] out2x2; 
    logic [3:0] add_to_mem2x2; 
    logic [3:0] st; 
    logic [2:0] c1, c2; 
    
    logic [3:0] det1add, det2add, det3add, ask_det_add, ask_add; 
    logic loaddet [0:2]; 
    logic loadmul [0:2];
    logic signed [15:0] det[2:0];
    logic signed [15:0] res[2:0]; 
    logic signed [15:0] muldet; 
    logic signed [15:0] mulres; 
    logic signed [15:0] final_add; 

    always @(*) begin
        case(add_to_mem2x2) 
            0: begin det1add = 4; det2add = 3; det3add = 3; end 
            1: begin det1add = 5; det2add = 5; det3add = 4; end 
            2: begin det1add = 7; det2add = 6; det3add = 6; end 
            3: begin det1add = 8; det2add = 8; det3add = 7; end 
        endcase
    end 
    always @(*) begin
        case(c1)
            0: ask_det_add = det1add; 
            1: ask_det_add = det2add; 
            2: ask_det_add = det3add;
        endcase
    end
    always @(*) begin
        case(c2) 
            0: begin muldet = det[0]; end 
            1: begin muldet = det[1]; end
            2: begin muldet = det[2]; end
        endcase
    end
    always @(*) begin
        case(selmux) 
            0: ask_add = ask_det_add; 
            1: ask_add = c2; 
        endcase
    end

    TopModule2x2 det2x2(.clk(clk), .reset(reset), .start(start2x2), .done(done2x2), .out(out2x2), .start_add(0), .data_in(data_in), .add_to_mem(add_to_mem2x2));

    register #(.n(8)) regst(.clk(clk), .reset(reset), .load(loadst), .D(start_address), .Q(st));

    signed_adder add_adder(.A(st), .B(ask_add), .C(add_to_mem)); 

    counter #(.n(3)) cnt1(.clk(clk), .reset(reset), .EnC(EnC1), .initC(0), .count(c1), .loadC(loadC1));
    counter #(.n(3)) cnt2(.clk(clk), .reset(reset), .EnC(EnC2), .initC(0), .count(c2), .loadC(loadC2));

    decoder decoder1(.num(c1), .out(loaddet)); 
    decoder decoder2(.num(c2), .out(loadmul));

    register #(.n(16)) regdet0(.clk(clk), .reset(reset), .load(loaddet[0]), .D(out2x2), .Q(det[0]));
    register #(.n(16)) regdet1(.clk(clk), .reset(reset), .load(loaddet[1]), .D(out2x2), .Q(det[1]));
    register #(.n(16)) regdet2(.clk(clk), .reset(reset), .load(loaddet[2]), .D(out2x2), .Q(det[2]));

    signed_multiplier #(.n(16)) multiplier(.A(muldet), .B(data_in), .C(mulres));

    register #(.n(16)) mulreg0(.clk(clk), .reset(reset), .load(loadmul[0]), .D(mulres), .Q(res[0]));
    register #(.n(16)) mulreg1(.clk(clk), .reset(reset), .load(loadmul[1]), .D(mulres), .Q(res[1]));
    register #(.n(16)) mulreg2(.clk(clk), .reset(reset), .load(loadmul[2]), .D(mulres), .Q(res[2]));

    signed_adder adder_last(.A(res[0]), .B(res[2]), .C(final_add)); 
    signed_subtractor subtractor_last(.A(final_add), .B(res[1]), .C(out)); 

    comparator #(.n(3)) eq1(.a(c1), .b(2), .equal(end1));
    comparator #(.n(3)) eq2(.a(c2), .b(2), .equal(end2));
endmodule