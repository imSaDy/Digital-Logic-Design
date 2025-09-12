module controller3x3(done2x2, end1, start, loadst, start2x2, EnC1, EnC2, selmux, loadC1, loadC2, end2, done3x3, clk, reset);
    input done2x2, end1, start, end2, clk, reset; 
    output logic done3x3, loadst, start2x2, EnC1, EnC2, selmux, loadC1, loadC2;
    parameter [3:0] IDLE = 0, INIT = 1, INIT2X2 = 2, CALCULATE2X2 = 3, CNT1 = 4, CHANGEMUX = 5, MUL = 6, CNT2 = 7; 
    logic [3:0] ps, ns; 
    always @(ps, start, end1, end2, done2x2) begin
        ns = IDLE; 
        case (ps) 
            IDLE: ns = (start ? INIT : IDLE); 
            INIT: ns = (start ? INIT : INIT2X2); 
            INIT2X2: ns = CALCULATE2X2; 
            CALCULATE2X2: ns = (done2x2 ? CNT1 : CALCULATE2X2); 
            CNT1: ns = (end1 ? CHANGEMUX : INIT2X2); 
            CHANGEMUX: ns = MUL; 
            MUL: ns = CNT2; 
            CNT2: ns = (end2 ? IDLE : MUL); 
        endcase
    end
    always @(posedge clk, posedge reset) begin
        if (reset == 1'b1)
            ps <= IDLE;
        else 
            ps <= ns; 
    end
    always @(ps, start) begin
        done3x3 = 0; loadst = 0; loadC1 = 0; loadC2 = 0; start2x2 = 0; EnC1 = 0; EnC2 = 0; selmux = 0; 
        case (ps)
            IDLE: done3x3 = 1'b1; 
            INIT: begin loadst = 1'b1; loadC1 = 1; loadC2 = 1; end
            INIT2X2: begin start2x2 = 1; end
            CALCULATE2X2: begin end
            CNT1: begin EnC1 = 1'b1; end
            CHANGEMUX: begin selmux = 1; end
            MUL: begin selmux = 1; end
            CNT2: begin selmux = 1; EnC2 = 1; end 
        endcase
    end
endmodule