`timescale 1ns/1ns
module sevenSegmentDecoder_TB();
	logic w,x,y,z;
	wire [6:0] test_out; 
	sevenSegmentDecoder UUT(w,x,y,z,test_out);
	initial begin 
		#0 {w ,x ,y ,z} = 4'b0000;
		#20 {w ,x ,y ,z} = 4'b0001;
		#20 {w ,x ,y ,z} = 4'b0010;
		#20 {w ,x ,y ,z} = 4'b0011;
		#20 {w ,x ,y ,z} = 4'b0100;
		#20 {w ,x ,y ,z} = 4'b0101;
		#20 {w ,x ,y ,z} = 4'b0110;
		#20 {w ,x ,y ,z} = 4'b0111;
		#20 {w ,x ,y ,z} = 4'b1000;
		#20 {w ,x ,y ,z} = 4'b1001;
		#20 {w ,x ,y ,z} = 4'b1010;
		#20 {w ,x ,y ,z} = 4'b1011;
		#20 {w ,x ,y ,z} = 4'b1100;
		#20 {w ,x ,y ,z} = 4'b1101;
		#20 {w ,x ,y ,z} = 4'b1110;
		#20 {w ,x ,y ,z} = 4'b1111;
		#20;
	end 
endmodule 