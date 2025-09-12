`timescale 1ns/1ns
module sevenSegmentDecoderBehavioral (input w,x,y,z ,output[6:0] out);
	assign out[0] = ((~x&~z) | y | w | (x&z));  
	assign out[1] = (~x | (y&z) | (~y&~z)); 
	assign out[2] = (~y | z | x); 
	assign out[3] = (w | (y&~z) | (~x&~z) | (x&~y&z) | (~x&y)); 
	assign out[4] = ((~x&~z) | (y&~z));
	assign out[5] = (w | (~y&~z) | (x&~y) | (x&~z)); 
	assign out[6] = (w | (x&~y) | (y&~z) | (~x&y));
endmodule