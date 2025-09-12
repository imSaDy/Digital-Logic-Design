`timescale 1ns/1ns
module TopModule_TB();
	logic [15:0] x ,y; 
	logic [2:0] opcode; 
	wire [15:0] test_out; 
	wire [6:0] seg_out; 
	wire overflow; 
	//Top_Module UUT(x, y, opcode, test_out, overflow);
	sevenSegmentDecoderFromOnehot UUT(x, y, opcode, test_out, overflow, seg_out); 
	initial 
	begin  
		x = 16'b0000000000001000; 
        y = 16'b0000000000000100;
        opcode = 3'b001; 
		#10;
		x = 16'b0000000001000000; //overflow 
        y = 16'b0000000010000000;
		opcode = 3'b001; 
		#10;
		x = 16'b0000000000001000; 
        y = 16'b0000000000100000; // negative result 
		opcode = 3'b010; 
		#10;
		x = 16'b0000000000100000; 
        y = 16'b0000000100000000; // overflow 
		opcode = 3'b010; 
		#10;
		x = 16'b0000000000001000; 
        y = 16'b0000000000010000;
		opcode = 3'b011; 
		#10;
		x = 16'b0000000000001000; 
        y = 16'b0000000100000000; // overflow
		opcode = 3'b011; 
		#10;
		x = 16'b0000000100000000; 
        y = 16'b0000000000000100; // overflow 
		opcode = 3'b100; 
		#10;
		x = 16'b0000000100000000; 
        y = 16'b1000000000000000; // two negative 
		opcode = 3'b100; 
		#10;
		x = 16'b0000000000100000; 
        y = 16'b0000000000100000; // equal case 
		opcode = 3'b101; 
		#10;
		x = 16'b0000000000001000; 
        y = 16'b0000000000000100;
		opcode = 3'b101; 
		#10;
		x = 16'b0000100000000000; 	
        y = 16'b0100000000000000; // two negative
		opcode = 3'b110; 
		#10;
		x = 16'b0000000000001000; 
        y = 16'b0010000000000000; // one negative and one positive 
		opcode = 3'b110; 
		#10;
		x = 16'b010000000000000; 
        y = 16'b100000000000000; // negative 
		opcode = 3'b111; 
		#10;
		x = 16'b0000000000000001; 
        y = 16'b0000000000000010; //positive 
		opcode = 3'b111; 
		#10;
	end 
endmodule 
