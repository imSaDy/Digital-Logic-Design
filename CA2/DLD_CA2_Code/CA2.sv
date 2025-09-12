module sevenSegmentDecoderFromOnehot(inp1, inp2, opcode, out, overflow ,test_out);
    input [15:0] inp1 ,inp2; 
    input [2:0] opcode; 
    output overflow; 
    output [15:0] out;
    Top_Module top_module1(inp1, inp2, opcode, out, overflow);
    wire [3:0] binary; 
    output [6:0] test_out; 
    encoder_onehot_to_binary encoder3(out, binary); 
    sevenSegmentDecoderBehavioral segDecoder(binary[3], binary[2], binary[1], binary[0] ,test_out);
endmodule

module Top_Module(inp1, inp2, opcode, out, overflow);
    input [15:0] inp1 ,inp2; 
    input [2:0] opcode; 
    output overflow; 
    output [15:0] out; 
    wire [3:0] binary1, binary2; 
    encoder_onehot_to_binary encoder1(inp1, binary1); 
    encoder_onehot_to_binary encoder2(inp2, binary2); 
    wire [3:0] z; 
    ALU alu(binary1, binary2, opcode, z, overflow);
    decoder_binary_to_onehot decoder(out, z); 
endmodule

module encoder_onehot_to_binary(onehot, binary);
    input [15:0] onehot; 
    output [3:0] binary; 
    logic [3:0] binary;
    always @(onehot)
        case (onehot)
            16'b0000000000000001: binary = 4'b0000; // 0
            16'b0000000000000010: binary = 4'b0001;
            16'b0000000000000100: binary = 4'b0010;
            16'b0000000000001000: binary = 4'b0011;
            16'b0000000000010000: binary = 4'b0100;
            16'b0000000000100000: binary = 4'b0101;
            16'b0000000001000000: binary = 4'b0110;
            16'b0000000010000000: binary = 4'b0111; // 7
            16'b0000000100000000: binary = 4'b1000; // -8
            16'b0000001000000000: binary = 4'b1001;
            16'b0000010000000000: binary = 4'b1010;
            16'b0000100000000000: binary = 4'b1011;
            16'b0001000000000000: binary = 4'b1100;
            16'b0010000000000000: binary = 4'b1101;
            16'b0100000000000000: binary = 4'b1110;
            16'b1000000000000000: binary = 4'b1111; // -1
        endcase
endmodule


module decoder_binary_to_onehot(onehot, binary);
    input [3:0] binary;  
    output [15:0] onehot; 
    logic [15:0] onehot;
    always @(binary)
        case (binary)
            4'b0000: onehot =  16'b0000000000000001; //0
            4'b0001: onehot =  16'b0000000000000010;
            4'b0010: onehot =  16'b0000000000000100;
            4'b0011: onehot =  16'b0000000000001000;
            4'b0100: onehot =  16'b0000000000010000;
            4'b0101: onehot =  16'b0000000000100000;
            4'b0110: onehot =  16'b0000000001000000;
            4'b0111: onehot =  16'b0000000010000000;
            4'b1000: onehot =  16'b0000000100000000; // -8
            4'b1001: onehot =  16'b0000001000000000;
            4'b1010: onehot =  16'b0000010000000000;
            4'b1011: onehot =  16'b0000100000000000;
            4'b1100: onehot =  16'b0001000000000000;
            4'b1101: onehot =  16'b0010000000000000;
            4'b1110: onehot =  16'b0100000000000000;
            4'b1111: onehot =  16'b1000000000000000; // -1
        endcase
endmodule


module CLA(input [3:0] x, input [3:0] y, input cin, output [3:0] s, output overflow); 
    wire [3:0] w;
    xor(w[3], y[3], cin);
    xor(w[2], y[2], cin);
    xor(w[1], y[1], cin);
    xor(w[0], y[0], cin);
    wire [4:0] c; 
    wire [3:0] p; 
    wire [3:0] g; 
    or(c[0], 0, cin);
    and(g[0], x[0], w[0]);
    and(g[1], x[1], w[1]);
    and(g[2], x[2], w[2]);
    and(g[3], x[3], w[3]);
    or(p[0], x[0], w[0]);
    or(p[1], x[1], w[1]);
    or(p[2], x[2], w[2]);
    or(p[3], x[3], w[3]);
    wire p0c0;
    and(p0c0, p[0], c[0]);
    or(c[1], p0c0, g[0]);
    wire p1g0, p1p0c0;
    and(p1g0, p[1], g[0]); 
    and(p1p0c0, p[1], p[0], c[0]);
    or(c[2], g[1], p1g0, p1p0c0);
    wire p2g1, p2p1g0, p2p1p0c0; 
    and(p2g1, p[2], g[1]); 
    and(p2p1g0, p[2], p[1], g[0]); 
    and(p2p1p0c0, p[2], p[1], p[0], c[0]);
    or(c[3], g[2], p2g1, p2p1g0, p2p1p0c0);
    wire p3g2, p3p2g1, p3p2p1g0, p3p2p1p0c0; 
    and(p3g2, p[3], g[2]);
    and(p3p2g1, p[3], p[2], g[1]); 
    and(p3p2p1g0, p[3], p[2], p[1], g[0]);
    and(p3p2p1p0c0, p[3], p[2], p[1], p[0], c[0]) ; 
    or(c[4], g[3], p3g2, p3p2g1, p3p2p1g0, p3p2p1p0c0); 
    xor(s[0], x[0], w[0], c[0]); 
    xor(s[1], x[1], w[1], c[1]); 
    xor(s[2], x[2], w[2], c[2]);
    xor(s[3], x[3], w[3], c[3]);
    xor(overflow, c[4], c[3]); 
endmodule

module comparator(input [3:0] x, input [3:0] y, output equal ,output less ,output greater);
    wire [3:0] i_not ; 
    xor(i_not[0], x[0], y[0]); 
    xor(i_not[1], x[1], y[1]);
    xor(i_not[2], x[2], y[2]);
    xor(i_not[3], x[3], y[3]);
    wire [3:0] i;
    not(i[0], i_not[0]);
    not(i[1], i_not[1]); 
    not(i[2], i_not[2]);
    not(i[3], i_not[3]);
    and(equal, i[0], i[1], i[2], i[3]); 
    wire [3:0] yn; 
    wire xn3 ; 
    not(xn3, x[3]); 
    not(yn[0], y[0]); 
    not(yn[1], y[1]); 
    not(yn[2], y[2]);
    not(yn[3], y[3]); 
    wire xn3y3; 
    and(xn3y3, xn3, y[3]);
    wire i3x2yn2;
    and(i3x2yn2, x[2], yn[2], i[3]);
    wire i3i2x1yn1; 
    and(i3i2x1yn1, i[3], i[2], x[1], yn[1]);
    wire i3i2i1x0yn0; 
    and(i3i2i1x0yn0, i[3], i[2], i[1], x[0], yn[0]);
    or(greater, xn3y3, i3x2yn2, i3i2x1yn1, i3i2i1x0yn0); 
    wire not_less; 
    or(not_less, greater, equal); 
    not(less, not_less); 
endmodule

module ALU(x, y, opcode, z, overflow);
    input [3:0] x, y; 
    input [2:0] opcode; 
    output overflow;
    output [3:0] z ;
    logic cin; 
    logic [3:0] z; 
    logic overflow; 
    wire [3:0] s; 
    CLA adder(x, y, cin, s, overflow);
    wire equal, less, greater; 
    comparator cmp(x, y, equal, less, greater);
    always @(*)
    begin
        case(opcode)
            3'b001:
            begin
                cin = 0;
                z = s; 
            end
            3'b010:
            begin
                cin = 1;
                z = s; 
            end
            3'b011:
            begin
                cin = 1; 
                if (s[3] == 1)
                    z = x; 
                else 
                    z = y; 
            end
            3'b100:
            begin
                cin = 1; 
                if (s[3] == 0)
                    z = x; 
                else 
                    z = y; 
            end
            3'b101:
            begin
                if (greater == 0)
                    z = x; 
                else 
                    z = y; 
                overflow = 1'b0; 
            end
            3'b110:
            begin
                if (greater == 1)
                    z = x; 
                else 
                    z = y; 
                overflow = 1'b0; 
            end
            3'b111:
            begin
                z = y; 
                overflow = 1'b0;
            end
        endcase
    end
endmodule