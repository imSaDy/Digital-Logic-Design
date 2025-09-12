module controller(start, loadC, EnC, loadA, loadmul, done, reset, clk);
    input logic start, reset, clk; 
    output logic loadC, EnC; 
    output logic loadA[2:1][2:1];
    output logic loadmul[2:1];
    output logic done; 
    parameter [3:0] IDLE = 0, INIT = 1, READA11 = 2, READA12 = 3, READA21 = 4, READA22 = 5, MUL1 = 6, MUL2 = 7, SUB = 8; 
    logic [3:0] ps, ns; 
    always @(ps, start) begin
        ns = IDLE; 
        case (ps) 
            IDLE: ns = (start ? INIT : IDLE); 
            INIT: ns = (start ? INIT : READA11); 
            READA11: ns = READA12; 
            READA12: ns = READA21; 
            READA21: ns = READA22; 
            READA22: ns = MUL1; 
            MUL1: ns = MUL2; 
            MUL2: ns = SUB; 
            SUB: ns = IDLE;
        endcase
    end
    always @(posedge clk, posedge reset) begin
        if (reset == 1'b1)
            ps <= IDLE;
        else 
            ps <= ns; 
    end
    always @(ps, start) begin
        done = 0; loadA[1][1] = 0; loadA[2][1] = 0; loadA[1][2] = 0; loadA[2][2] = 0; 
        EnC = 0; loadC = 0; loadmul[1] = 0; loadmul[2] = 0; 
        case (ps)
            IDLE: done = 1'b1; 
            INIT: loadC = 1'b1; 
            READA11: begin EnC = 1'b1; loadA[1][1] = 1'b1; end
            READA12: begin EnC = 1'b1; loadA[1][2] = 1'b1; end
            READA21: begin EnC = 1'b1; loadA[2][1] = 1'b1; end
            READA22: begin EnC = 1'b1; loadA[2][2] = 1'b1; end
            MUL1: loadmul[1] = 1'b1;
            MUL2: loadmul[2] = 1'b1; 
            SUB: done = 1'b1;
        endcase
    end
endmodule